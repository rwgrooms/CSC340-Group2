package com.realestatedirect.api.crud;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/images")
public class ImageController {

    @Autowired
    private ImageService imageService;

    @GetMapping
    public List<Image> getAllImages() {
        return imageService.getAllImages();
    }

    @GetMapping("/{id}")
    public Optional<Image> getImageById(@PathVariable Long id) {
        return imageService.getImageById(id);
    }

    @PostMapping
    public Image createImage(@RequestBody Image image) {
        return imageService.saveImage(image);
    }

    @PutMapping("/{id}")
    public Image updateImage(@PathVariable Long id, @RequestBody Image image) {
        return imageService.updateImage(id, image);
    }

    @DeleteMapping("/{id}")
    public void deleteImage(@PathVariable Long id) {
        imageService.deleteImage(id);
    }
}