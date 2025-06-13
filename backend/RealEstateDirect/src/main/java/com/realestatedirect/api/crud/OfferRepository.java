package com.realestatedirect.api.crud;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OfferRepository extends JpaRepository<Offer, Long> {
    // For buyers
    List<Offer> findByBuyer_UserId(Long buyerId);

    // For sellers — based on the property's seller
    @Query("SELECT o FROM Offer o WHERE o.property.seller.id = :sellerId")
    List<Offer> findBySellerId(@Param("sellerId") Long sellerId);
}
