package com.realestatedirect.api.crud;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
public class Property {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long propertyId;
    private String addressLine1;
    private String addressLine2;
    private String city;
    private String state;
    private String zipCode;
    private String description;
    private Double askingPrice;
    private Double goodFaithDeposit;

    @ManyToOne
    @JoinColumn(name = "sellerId", nullable = false)
    private User seller;

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL)
    private List<Image> images;

    @OneToMany(mappedBy = "property", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Offer> offer = new ArrayList<>();

    public List<Offer> getOffer() {
        return offer;
    }

    public void setOffer(List<Offer> offer) {
        this.offer = offer;
    }

    public Long getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(Long propertyId) {
        this.propertyId = propertyId;
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getAskingPrice() {
        return askingPrice;
    }

    public void setAskingPrice(Double askingPrice) {
        this.askingPrice = askingPrice;
    }

    public Double getGoodFaithDeposit() {
        return goodFaithDeposit;
    }

    public void setGoodFaithDeposit(Double goodFaithDeposit) {
        this.goodFaithDeposit = goodFaithDeposit;
    }

    public User getSeller() {
        return seller;
    }

    public void setSeller(User seller) {
        this.seller = seller;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }
}
