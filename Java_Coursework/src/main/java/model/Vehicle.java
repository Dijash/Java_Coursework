package model;

public class Vehicle {
    private int vehicle_id;
    private String vehicle_brand;
    private String vehicle_type;
    private String vehicle_color;
    private String vehicle_numberPlate;
    private String vehicle_condition;
    private String vehicle_status;
    private String vehicle_image;

    // Updated Constructor
    public Vehicle(int vehicle_id, String vehicle_brand, String vehicle_type,
                   String vehicle_color, String vehicle_numberPlate,
                   String vehicle_condition, String vehicle_status, String vehicle_image) {
        this.vehicle_id = vehicle_id;
        this.vehicle_brand = vehicle_brand;
        this.vehicle_type = vehicle_type;
        this.vehicle_color = vehicle_color;
        this.vehicle_numberPlate = vehicle_numberPlate;
        this.vehicle_condition = vehicle_condition;
        this.vehicle_status = vehicle_status;
        this.vehicle_image = vehicle_image; // Bind it here
    }

    // Getters
    public int getVehicle_id() { return vehicle_id; }
    public String getVehicle_brand() { return vehicle_brand; }
    public String getVehicle_type() { return vehicle_type; }
    public String getVehicle_color() { return vehicle_color; }
    public String getVehicle_numberPlate() { return vehicle_numberPlate; }
    public String getVehicle_condition() { return vehicle_condition; }
    public String getVehicle_status() { return vehicle_status; }
    public String getVehicle_image() { return vehicle_image; }
}