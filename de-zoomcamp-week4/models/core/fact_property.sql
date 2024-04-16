{{

    config (
        materialized = 'table'
    )
}}

with otodom_property as (
    select *,
        'otodom' as service_type
    from {{ ref('stg_property_data')}}
) 

select
    otodom_property.id,
    MIN(DATE(otodom_property.added_date)) as yearliest_added_date,
    MAX(DATE(otodom_property.update_date)) as latest_update_date,
    MIN(otodom_property.price) as initial_price,
    MAX(otodom_property.price) as latest_price,
    AVG(otodom_property.area) as area,
    MIN(otodom_property.price_per_m2) as min_price_per_m2,
    MAX(otodom_property.price_per_m2) as max_price_per_m2,
    MAX(heating) as heating,
    MAX(form_of_ownership) as form_of_ownership,
    MAX(condition) as condition,
    MAX(arrangements) as arrangements

from otodom_property
where id > 0 AND price_per_m2 > 0
group by otodom_property.id


    -- otodom_property.download_date,
    -- otodom_property.download_time,
    -- otodom_property.id,
    -- otodom_property.added_date,
    -- otodom_property.update_date,
    -- otodom_property.price,
    -- otodom_property.area,
    -- otodom_property.rooms,
    -- otodom_property.floor,
    -- otodom_property.rent,
    -- otodom_property.form_of_ownership,
    -- otodom_property.condition,
    -- otodom_property.arrangements,
    -- otodom_property.heating,
    -- otodom_property.market,
    -- otodom_property.advertiser_type,
    -- otodom_property.building_year,
    -- otodom_property.material1,
    -- otodom_property.elevator,
    -- otodom_property.material2,
    -- otodom_property.link,
    -- otodom_property.price_per_m2,
    -- otodom_property.service_type

