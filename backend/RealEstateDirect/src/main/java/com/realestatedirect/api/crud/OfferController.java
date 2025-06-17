package com.realestatedirect.api.crud;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/api/offers")
public class OfferController {

    @Autowired
    private OfferService offerService;

    @Autowired
    private PropertyService propertyService;

    @Autowired
    private UserService userService;

    // @GetMapping
    // public List<Offer> getAllOffers() {
    //     return offerService.getAllOffers();
    // }

    // @GetMapping("/{id}")
    // public Optional<Offer> getOfferById(@PathVariable Long id) {
    //     return offerService.getOfferById(id);
    // }

    @GetMapping("/create/{id}")
    public Object ShowCreateOfferPage(@PathVariable Long id, @RequestParam Long userId, Model model) {
        Property property = propertyService.getPropertyById(id).orElse(null);
        User user = userService.getUserById(userId).orElse(null);
        model.addAttribute("property", property);
        model.addAttribute("currentUser", user);
        return "make-offer";
    }

    @PostMapping("/create")
    public Object createOffer(@RequestParam Long propertyId, @RequestParam Long userId, Offer offer) {
        User user = userService.getUserById(userId).orElse(null);
        Property property = propertyService.getPropertyById(propertyId).orElse(null);
        offer.setProperty(property);
        offer.setStatus("Offer");
        offer.setBuyer(user);
        offerService.saveOffer(offer);
        return "welcome";
    }

    // @PutMapping("/{id}")
    // public Offer updateOffer(@PathVariable Long id, @RequestBody Offer offer) {
    //     return offerService.updateOffer(id, offer);
    // }

    // @DeleteMapping("/{id}")
    // public void deleteOffer(@PathVariable Long id) {
    //     offerService.deleteOffer(id);
    // }

    @GetMapping("/myoffers/{id}")
    public String getMyOffers(@PathVariable Long id, Model model) {
        User currentUser = userService.getUserById(id).orElse(null);
        List<Offer> offers = offerService.getOffersForUser(currentUser);
        model.addAttribute("offers", offers);
        model.addAttribute("currentUser", currentUser);
        return "view-offers";
    }

    @PostMapping("/update")
    public Object updateOffer(@RequestParam Long propertyId, @RequestParam Long userId, Offer offer) {
        Offer updatedOffer = offerService.getOfferById(offer.getOfferId()).orElse(null);
        Property property = propertyService.getPropertyById(propertyId).orElse(null);
        updatedOffer.setProperty(property);
        updatedOffer.setGoodFaithDeposit(offer.getGoodFaithDeposit());
        updatedOffer.setOfferPrice(offer.getOfferPrice());
        updatedOffer.setCounterOfferPrice(offer.getCounterOfferPrice());
        updatedOffer.setStatus(offer.getStatus());

        offerService.updateOffer(updatedOffer.getOfferId(), updatedOffer);
        return "welcome";
    }
}
