DELETE FROM restaurants;

INSERT INTO restaurants (url, name, categories, x, y, xy, address, website, phone_number, price_range, rating, review_count, hours, good_for, delivery, take_out, reservations)

SELECT * FROM dblink('dbname=yelp', '
    SELECT
        url,
        name,
        sub_categories,
        x_coordinate,
        y_coordinate,
        ST_SetSRID(ST_Point(x_coordinate, y_coordinate), 4326),
        address,
        website,
        phone_number,
        price_range,
        rating,
        review_count,
        hours,
        good_for,
        delivery,
        take_out,
        reservations
    FROM entries
') AS (
    url             char(255),
    name            char(255),
    categories      char(255),
    x               float,
    y               float,
    xy              geometry,
    address         char(255),
    website         char(255),
    phone_number    char(16),
    price_range     char(4),
    rating          float,
    review_count    integer,
    hours           char(255),
    good_for        char(255),
    delivery        boolean,
    take_out        boolean,
    reservations    boolean
);
