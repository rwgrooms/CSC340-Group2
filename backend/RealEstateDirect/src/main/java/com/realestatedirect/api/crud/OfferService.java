package com.realestatedirect.api.crud;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class OfferService {

    @Autowired
    private OfferRepository offerRepository;

    public List<Offer> getAllOffers() {
        return offerRepository.findAll();
    }

    public Optional<Offer> getOfferById(Long id) {
        return offerRepository.findById(id);
    }

    public Offer saveOffer(Offer offer) {
        return offerRepository.save(offer);
    }

    public void deleteOffer(Long id) {
        offerRepository.deleteById(id);
    }

    public Offer updateOffer(Long id, Offer updatedOffer) {
        updatedOffer.setOfferId(id);
        return offerRepository.save(updatedOffer);
    }

    public List<Offer> getOffersForUser(User user) {
        if (user.getRole() == 1) {
            return offerRepository.findByBuyer_UserId(user.getUserId());
        } else if (user.getRole() == 2) {
            return offerRepository.findBySellerId(user.getUserId());
        } else {
            return Collections.emptyList();
        }
    }
}
