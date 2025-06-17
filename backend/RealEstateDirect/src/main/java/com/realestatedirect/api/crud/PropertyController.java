package com.realestatedirect.api.crud;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/api/properties")
public class PropertyController {

    private final OfferService offerService;

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private UserService userService;
        
    @Autowired
    private ImageService imageService;

    //private final String UPLOAD_DIR = "/src/main/resources/imageuploads/";
    private final String UPLOAD_DIR = System.getProperty("user.home") + "/realestate-uploads/";

    PropertyController(OfferService offerService) {
        this.offerService = offerService;
    }

    @GetMapping("/listings/{id}")
    public String getAllProperties(@PathVariable Long id, Model model) {
        List<Property> properties = propertyService.getAllProperties();
        model.addAttribute("properties", properties);
        model.addAttribute("currentUser", userService.getUserById(id).orElse(null));
        return "view-listings";
    }

    @GetMapping("/{id}")
    public String getPropertyById(@PathVariable Long id, 
    Model model,
    Principal principal) {
        Property property = propertyService.getPropertyById(id).orElse(null);
        model.addAttribute("property", property);
        User currentUser = userService.getUserByEmail(principal.getName()).orElse(null);
        model.addAttribute("currentUser", currentUser);
        return "property-details";
    }

    @GetMapping("/create/{id}")
    public String showCreatePropertyForm(@PathVariable Long id, Model model) {
        model.addAttribute("sellerId", id);
        model.addAttribute("property", new Property());
        //return "test";
        return "list-property";
    }


    @PostMapping("/create/{id}")
    public String createProperty(
            Property property,
            @RequestParam("imageFiles") MultipartFile[] imageFiles,
            @PathVariable Long id,
            Model model) {
        User seller = userService.getUserById(id).orElse(null);
        property.setSeller(seller);
        Property savedProperty = propertyService.saveProperty(property);
        
        if (imageFiles != null && imageFiles.length > 0 && !imageFiles[0].isEmpty()) {
            List<Image> images = saveUploadedImages(imageFiles, savedProperty);
            savedProperty.setImages(images);
            propertyService.saveProperty(savedProperty);
        }
        
        model.addAttribute("property", savedProperty);
        model.addAttribute("user", seller);
        return "welcome";
    }

    @GetMapping("/edit/{id}")
    public String showEditPropertyForm(@PathVariable Long id, Model model) {
        Property property = propertyService.getPropertyById(id).orElse(null);
        model.addAttribute("property", property);
        return "update-property";
    }

    @PostMapping("/update")
    public String updateProperty(
            Property property, 
            @RequestParam(value = "imageFiles", required = false) MultipartFile[] imageFiles,
            Model model,
            Principal principal) {
        
        User seller = userService.getUserByEmail(principal.getName()).orElse(null);
        //User seller = userService.getUserById(principal. id).orElse(null);
        //property.setSeller(seller);

        Property existingProperty = propertyService.getPropertyById(property.getPropertyId()).orElse(null);
        if (existingProperty != null) {
            property.setImages(existingProperty.getImages());
        }

        Property savedProperty = propertyService.saveProperty(property);
        
        if (savedProperty != null) {
                    // Remove and delete images
                    if (savedProperty.getImages() != null) {
                        Iterator<Image> iterator = savedProperty.getImages().iterator();
                        while (iterator.hasNext()) {
                            Image image = iterator.next();
                            iterator.remove(); // remove from Property's list
                            imageService.deleteImage(image.getImageId()); // then delete from DB
                        }
                        propertyService.saveProperty(savedProperty); // persist image removal
                    }
        }

        if (imageFiles != null && imageFiles.length > 0 && !imageFiles[0].isEmpty()) {
            List<Image> images = saveUploadedImages(imageFiles, savedProperty);
            savedProperty.setImages(images);
            propertyService.saveProperty(savedProperty);
        }
        
        model.addAttribute("property", savedProperty);
        model.addAttribute("user", seller);
        return "welcome";

        // Property existingProperty = propertyService.getPropertyById(property.getPropertyId()).orElse(null);
        // if (existingProperty != null) {
        //     property.setImages(existingProperty.getImages());
        // }
        
        // Property updatedProperty = propertyService.updateProperty(property.getPropertyId(), property);
        
        // if (imageFiles != null && imageFiles.length > 0) {
        //     List<Image> newImages = saveUploadedImages(imageFiles, updatedProperty);
            
        //     if (updatedProperty.getImages() == null) {
        //         updatedProperty.setImages(new ArrayList<>());
        //     }
        //     updatedProperty.getImages().addAll(newImages);
            
        //     propertyService.saveProperty(updatedProperty);
        // }
        
        // model.addAttribute("property", updatedProperty);
        // return "redirect:/api/properties/" + updatedProperty.getPropertyId();
    }

    @GetMapping("/delete/{id}")
    public String deleteProperty(@PathVariable Long id) {
        Property prop = propertyService.getPropertyById(id).orElse(null);
         if (prop != null) {
            // Remove and delete images
            if (prop.getImages() != null) {
                Iterator<Image> iterator = prop.getImages().iterator();
                while (iterator.hasNext()) {
                    Image image = iterator.next();
                    iterator.remove(); // remove from Property's list
                    imageService.deleteImage(image.getImageId()); // then delete from DB
                }
                propertyService.saveProperty(prop); // persist image removal
            }

            // Remove and delete offers
            if (prop.getOffer() != null) {
                Iterator<Offer> offerIterator = prop.getOffer().iterator();
                while (offerIterator.hasNext()) {
                    Offer offer = offerIterator.next();
                    offerIterator.remove();
                    offerService.deleteOffer(offer.getOfferId());
                }
                propertyService.saveProperty(prop); // optional if offers are cascade removed
            }

            propertyService.deleteProperty(id);
        }
        return "welcome";
    }
    
    // Helper method
    private List<Image> saveUploadedImages(MultipartFile[] files, Property property) {
        List<Image> savedImages = new ArrayList<>();
        
        try {
            File directory = new File(UPLOAD_DIR);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            
            for (MultipartFile file : files) {
                if (file.isEmpty()) continue;
                
                String fileName = UUID.randomUUID() + "-" + file.getOriginalFilename();
                
                Path path = Paths.get(UPLOAD_DIR + fileName);
                Files.write(path, file.getBytes());
                
                Image image = new Image();
                image.setPath("/uploads/" + fileName);
                image.setProperty(property);
                Image savedImage = imageService.saveImage(image);
                savedImages.add(savedImage);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return savedImages;
    }
}