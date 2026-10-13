package com.localbiz.model;

public class Business {
    private int businessId, ownerId, categoryId, areaId;
    private String businessName, description, streetAddress, phone, email, logoPath, status, categoryName, areaName;
    public int getBusinessId(){return businessId;} public void setBusinessId(int v){businessId=v;}
    public int getOwnerId(){return ownerId;} public void setOwnerId(int v){ownerId=v;}
    public int getCategoryId(){return categoryId;} public void setCategoryId(int v){categoryId=v;}
    public int getAreaId(){return areaId;} public void setAreaId(int v){areaId=v;}
    public String getBusinessName(){return businessName;} public void setBusinessName(String v){businessName=v;}
    public String getDescription(){return description;} public void setDescription(String v){description=v;}
    public String getStreetAddress(){return streetAddress;} public void setStreetAddress(String v){streetAddress=v;}
    public String getPhone(){return phone;} public void setPhone(String v){phone=v;}
    public String getEmail(){return email;} public void setEmail(String v){email=v;}
    public String getLogoPath(){return logoPath;} public void setLogoPath(String v){logoPath=v;}
    public String getStatus(){return status;} public void setStatus(String v){status=v;}
    public String getCategoryName(){return categoryName;} public void setCategoryName(String v){categoryName=v;}
    public String getAreaName(){return areaName;} public void setAreaName(String v){areaName=v;}
}
