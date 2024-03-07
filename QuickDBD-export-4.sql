-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [orders] (
    [row_id] int  NOT NULL ,
    [order_id] varchar(10)  NOT NULL ,
    [created_at] datetime  NOT NULL ,
    [item_id] varchar(10)  NOT NULL ,
    [quantity] int  NOT NULL ,
    [cust_id] int  NOT NULL ,
    [delivery] boolean  NOT NULL ,
    [add_id] int  NOT NULL ,
    CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [customers] (
    [cust_id] int  NOT NULL ,
    [cust_firstname] varchar(50)  NOT NULL ,
    [cust_lastname] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED (
        [cust_id] ASC
    )
)

CREATE TABLE [address] (
    [add_id] int  NOT NULL ,
    [delivery_address1] varchar(200)  NOT NULL ,
    [delivery_address2] varchar(200)  NULL ,
    [delivery_county] varchar(50)  NOT NULL ,
    [delivery_eircode] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED (
        [add_id] ASC
    )
)

CREATE TABLE [item] (
    [item_id] varchar(10)  NOT NULL ,
    [sku] varchar(20)  NOT NULL ,
    [item_name] varchar(100)  NOT NULL ,
    [item_cat] varchar(100)  NOT NULL ,
    [item_size] varchar(10)  NOT NULL ,
    [item_price] decimal(10,2)  NOT NULL ,
    CONSTRAINT [PK_item] PRIMARY KEY CLUSTERED (
        [item_id] ASC
    )
)

CREATE TABLE [component] (
    [comp_id] varchar  NOT NULL ,
    [comp_name] varchar(200)  NOT NULL ,
    [comp_weight] int  NOT NULL ,
    [comp_meas] varchar(20)  NOT NULL ,
    [comp_price] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_component] PRIMARY KEY CLUSTERED (
        [comp_id] ASC
    )
)

CREATE TABLE [assembling] (
    [row_id] int  NOT NULL ,
    [assembly_id] varchar(20)  NOT NULL ,
    [comp_id] varchar(10)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_assembling] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [inventory] (
    [inv_id] int  NOT NULL ,
    [item_id] varchar(10)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_inventory] PRIMARY KEY CLUSTERED (
        [inv_id] ASC
    )
)

CREATE TABLE [rota] (
    [row_id] int  NOT NULL ,
    [rota_id] varchar(20)  NOT NULL ,
    [date_id] datetime  NOT NULL ,
    [shift_id] varchar(20)  NOT NULL ,
    [staff_id] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_rota] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [staff] (
    [staff_id] varchar(20)  NOT NULL ,
    [first_name] varchar(50)  NOT NULL ,
    [last_name] varchar(50)  NOT NULL ,
    [position] varchar(100)  NOT NULL ,
    [hourly_rate] decimal(5,2)  NOT NULL ,
    CONSTRAINT [PK_staff] PRIMARY KEY CLUSTERED (
        [staff_id] ASC
    )
)

CREATE TABLE [shift] (
    [shift_id] varchar(20)  NOT NULL ,
    [day_of_week] varchar(10)  NOT NULL ,
    [start_time] time  NOT NULL ,
    [end_time] time  NOT NULL ,
    CONSTRAINT [PK_shift] PRIMARY KEY CLUSTERED (
        [shift_id] ASC
    )
)

ALTER TABLE [customers] WITH CHECK ADD CONSTRAINT [FK_customers_cust_id] FOREIGN KEY([cust_id])
REFERENCES [orders] ([cust_id])

ALTER TABLE [customers] CHECK CONSTRAINT [FK_customers_cust_id]

ALTER TABLE [address] WITH CHECK ADD CONSTRAINT [FK_address_add_id] FOREIGN KEY([add_id])
REFERENCES [orders] ([add_id])

ALTER TABLE [address] CHECK CONSTRAINT [FK_address_add_id]

ALTER TABLE [item] WITH CHECK ADD CONSTRAINT [FK_item_item_id] FOREIGN KEY([item_id])
REFERENCES [orders] ([item_id])

ALTER TABLE [item] CHECK CONSTRAINT [FK_item_item_id]

ALTER TABLE [component] WITH CHECK ADD CONSTRAINT [FK_component_comp_id] FOREIGN KEY([comp_id])
REFERENCES [assembling] ([comp_id])

ALTER TABLE [component] CHECK CONSTRAINT [FK_component_comp_id]

ALTER TABLE [assembling] WITH CHECK ADD CONSTRAINT [FK_assembling_assembly_id] FOREIGN KEY([assembly_id])
REFERENCES [item] ([sku])

ALTER TABLE [assembling] CHECK CONSTRAINT [FK_assembling_assembly_id]

ALTER TABLE [inventory] WITH CHECK ADD CONSTRAINT [FK_inventory_item_id] FOREIGN KEY([item_id])
REFERENCES [assembling] ([comp_id])

ALTER TABLE [inventory] CHECK CONSTRAINT [FK_inventory_item_id]

ALTER TABLE [rota] WITH CHECK ADD CONSTRAINT [FK_rota_date_id] FOREIGN KEY([date_id])
REFERENCES [orders] ([created_at])

ALTER TABLE [rota] CHECK CONSTRAINT [FK_rota_date_id]

ALTER TABLE [rota] WITH CHECK ADD CONSTRAINT [FK_rota_staff_id] FOREIGN KEY([staff_id])
REFERENCES [staff] ([staff_id])

ALTER TABLE [rota] CHECK CONSTRAINT [FK_rota_staff_id]

ALTER TABLE [shift] WITH CHECK ADD CONSTRAINT [FK_shift_shift_id] FOREIGN KEY([shift_id])
REFERENCES [rota] ([shift_id])

ALTER TABLE [shift] CHECK CONSTRAINT [FK_shift_shift_id]

COMMIT TRANSACTION QUICKDBD