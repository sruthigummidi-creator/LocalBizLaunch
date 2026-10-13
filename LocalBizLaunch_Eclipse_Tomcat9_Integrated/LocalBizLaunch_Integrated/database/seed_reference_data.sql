-- Optional reference data only. Does not drop or recreate your tables.
USE localbiz_launch;
INSERT IGNORE INTO business_categories (category_name, description) VALUES
('Food & Homemade Products','Homemade food and local food products'),
('Bakery & Cakes','Cakes, pastries, bread and baked goods'),
('Clothing & Fashion','Clothing and fashion accessories'),
('Handmade Products','Handcrafted gifts and decorative items'),
('Local Services','Repair, maintenance and other local services');
INSERT IGNORE INTO website_templates (template_name, description) VALUES
('Fresh & Natural','Clean design for food and natural products'),
('Elegant Boutique','Elegant design for fashion businesses'),
('Creative Showcase','Flexible design for handmade products and services');
