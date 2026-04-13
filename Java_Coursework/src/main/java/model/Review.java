package model;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int customerId;
    private String customerName; // From JOIN
    private String reviewDescription;
    private Timestamp reviewDate;

    public Review(int reviewId, int customerId, String customerName, String reviewDescription, Timestamp reviewDate) {
        this.reviewId = reviewId;
        this.customerId = customerId;
        this.customerName = customerName;
        this.reviewDescription = reviewDescription;
        this.reviewDate = reviewDate;
    }

    public int getReviewId() { return reviewId; }
    public String getCustomerName() { return customerName; }
    public String getReviewDescription() { return reviewDescription; }
    public Timestamp getReviewDate() { return reviewDate; }
}