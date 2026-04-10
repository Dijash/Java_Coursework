package model;

public class Booking {
    private String customerName;
    private String vehicleName;
    private String endDate;
    private String status;

    public Booking(String customerName, String vehicleName, String endDate, String status) {
        this.customerName = customerName;
        this.vehicleName = vehicleName;
        this.endDate = endDate;
        this.status = status;
    }

    public String getCustomerName() { return customerName; }
    public String getVehicleName() { return vehicleName; }
    public String getEndDate() { return endDate; }
    public String getStatus() { return status; }
}