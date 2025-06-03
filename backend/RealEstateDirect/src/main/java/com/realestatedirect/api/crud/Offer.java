package com.realestatedirect.api.crud;

import jakarta.persistence.*;

@Entity
public class Offer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long offerId;
    private Double offerPrice;
    private Double goodFaithDeposit;
    private String status;
    private Double counterOfferPrice;

    @ManyToOne
    @JoinColumn(name = "propertyId", nullable = false)
    private Property property;

    @ManyToOne
    @JoinColumn(name = "buyerId", nullable = false)
    private User buyer;

    public Long getOfferId() {
        return offerId;
    }

    public void setOfferId(Long offerId) {
        this.offerId = offerId;
    }

    public Double getOfferPrice() {
        return offerPrice;
    }

    public void setOfferPrice(Double offerPrice) {
        this.offerPrice = offerPrice;
    }

    public Double getGoodFaithDeposit() {
        return goodFaithDeposit;
    }

    public void setGoodFaithDeposit(Double goodFaithDeposit) {
        this.goodFaithDeposit = goodFaithDeposit;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Double getCounterOfferPrice() {
        return counterOfferPrice;
    }

    public void setCounterOfferPrice(Double counterOfferPrice) {
        this.counterOfferPrice = counterOfferPrice;
    }

    public Property getProperty() {
        return property;
    }

    public void setProperty(Property property) {
        this.property = property;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }
}
