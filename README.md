# Data-Engineering-ZoomCamp

*Homework 1*
    
    Q1:  --rm 
    Q2:  0.42.0 
    docker run -it --entrypoint bash python:3.9 
    Q3: 15767 
    SELECT  
    COUNT(1) 
    FROM public.green_taxi_data 
    WHERE lpep_pickup_datetime::date >= '2019-09-18'  AND lpep_pickup_datetime::date < '2019-09-19' 
    LIMIT 100; 
    Q4: 2019-09-26 
    SELECT  
    lpep_pickup_datetime as "pickup", trip_distance as "distance", total_amount 
    FROM public.green_taxi_data 
    ORDER BY "distance" DESC 
    LIMIT 100; 
    Q5: "Brooklyn" "Manhattan" "Queens" 
    SELECT  
    z."Borough", 
    SUM(t."total_amount") 
    FROM  
    public.green_taxi_data t JOIN zones z 
    ON t."PULocationID" = z."LocationID" 
    WHERE  
    lpep_pickup_datetime::date >= '2019-09-18' AND lpep_pickup_datetime::date < '2019-09-19' 
    GROUP BY z."Borough" 
    ORDER BY SUM(t."total_amount") DESC 
    Q6: JFK Airport 
    SELECT  
    t."PULocationID", 
    t."DOLocationID", 
    zpu."Zone" as "PUZone", 
    zdo."Zone" as "DOZone", 
    t."tip_amount" 
    FROM  
    public.green_taxi_data t JOIN zones zpu 
    ON t."PULocationID" = zpu."LocationID" 
    JOIN zones zdo 
    ON t."DOLocationID" = zdo."LocationID" 
    WHERE  
    lpep_pickup_datetime::date >= '2019-09-01' AND lpep_pickup_datetime::date < '2019-10-01' AND zpu."Zone" = 'Astoria' 
    ORDER BY t."tip_amount" DESC 
    Q7:
    Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
    symbols:
      + create
    
    Terraform will perform the following actions:
    
      # google_bigquery_dataset.demo_dataset will be created
      + resource "google_bigquery_dataset" "demo_dataset" {
          + creation_time              = (known after apply)
          + dataset_id                 = "demo_dataset"
          + default_collation          = (known after apply)
          + delete_contents_on_destroy = false
          + effective_labels           = (known after apply)
          + etag                       = (known after apply)
          + id                         = (known after apply)
          + is_case_insensitive        = (known after apply)
          + last_modified_time         = (known after apply)
          + location                   = "EU"
          + max_time_travel_hours      = (known after apply)
          + project                    = "silent-blade-412220"
          + self_link                  = (known after apply)
          + storage_billing_model      = (known after apply)
          + terraform_labels           = (known after apply)
        }
    
      # google_storage_bucket.demo-bucket will be created
      + resource "google_storage_bucket" "demo-bucket" {
          + effective_labels            = (known after apply)
          + force_destroy               = true
          + id                          = (known after apply)
          + location                    = "EU"
          + name                        = "silent-blade-412220"
          + project                     = (known after apply)
          + public_access_prevention    = (known after apply)
          + rpo                         = (known after apply)
          + self_link                   = (known after apply)
          + storage_class               = "STANDARD"
          + terraform_labels            = (known after apply)
          + uniform_bucket_level_access = (known after apply)
          + url                         = (known after apply)
    
          + lifecycle_rule {
              + action {
                  + type = "AbortIncompleteMultipartUpload"
                }
              + condition {
                  + age                   = 1
                  + matches_prefix        = []
                  + matches_storage_class = []
                  + matches_suffix        = []
                  + with_state            = (known after apply)
                }
            }
        }
    
    Plan: 2 to add, 0 to change, 0 to destroy.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    google_bigquery_dataset.demo_dataset: Creating...
    google_storage_bucket.demo-bucket: Creating...
    google_bigquery_dataset.demo_dataset: Creation complete after 2s [id=projects/silent-blade-412220/datasets/demo_dataset]
    google_storage_bucket.demo-bucket: Creation complete after 3s [id=silent-blade-412220]
    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
    
*Homework 2*

    Q1: 266,855 rows x 20 columns
        
            import io
        import pandas as pd
        import requests
        if 'data_loader' not in globals():
            from mage_ai.data_preparation.decorators import data_loader
        if 'test' not in globals():
            from mage_ai.data_preparation.decorators import test
        
        
        @data_loader
        def load_data_from_api(*args, **kwargs):
            """
            Template for loading data from API
            """
            appended_data = []
            for i in range(10,13):
        
                url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-{i}.csv.gz"
                print(url)
                taxi_dtypes = {
                                'passenger_count': pd.Int64Dtype(),
                                'trip_distance': float,
                                'RatecodeID':pd.Int64Dtype(),
                                'store_and_fwd_flag':str,
                                'PULocationID':pd.Int64Dtype(),
                                'DOLocationID':pd.Int64Dtype(),
                                'payment_type': pd.Int64Dtype(),
                                'fare_amount': float,
                                'extra':float,
                                'mta_tax':float,
                                'tip_amount':float,
                                'tolls_amount':float,
                                'improvement_surcharge':float,
                                'total_amount':float,
                                'congestion_surcharge':float  
                }
        
                # native date parsing 
                parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']
        
        
                data = pd.read_csv(url, sep=',', compression='gzip',dtype = taxi_dtypes, parse_dates = parse_dates)
                appended_data.append(data)
        
            appended_data = pd.concat(appended_data)
            
            return appended_data
        
            #, dtype=taxi_dtypes, parse_dates=parse_dates
        
        @test
        def test_output(output, *args) -> None:
            """
            Template code for testing the output of the block.
            """
            assert output is not None, 'The output is undefined'
    
    Q2: 139,370 rows

                        if 'transformer' not in globals():
                from mage_ai.data_preparation.decorators import transformer
            if 'test' not in globals():
                from mage_ai.data_preparation.decorators import test
            
            
            @transformer
            def transform(data, *args, **kwargs):
                # Specify your transformation logic here
                data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
            
            
                data1 = data[data['passenger_count'] > 0]
                return data1[data1['trip_distance'] > 0]
            
            
            @test
            def test_output(output, *args) -> None:
                """
                Template code for testing the output of the block.
                """
                assert output is not None, 'The output is undefined'
            
    Q3: answ.3 data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    
    Q4: 1 or 2

        SELECT VendorID
        FROM mage.green_taxi
        GROUP BY VendorID
    
    Q5: 4

        
    
    Q6: 96 parts

                    from mage_ai.settings.repo import get_repo_path
        from mage_ai.io.config import ConfigFileLoader
        from mage_ai.io.google_cloud_storage import GoogleCloudStorage
        from pandas import DataFrame
        import pyarrow as pa 
        import pyarrow.parquet as pq
        import os
        
        # Set the path to the credentials file
        credentials_file = "/home/src/silent-blade-412220-f684e4cab1ad.json"
        
        # Set the environment variable directly
        os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credentials_file
        
        
        bucket_name = 'mage-zoomcamp-hutsal'
        project_id = 'silent-blade-412220'
        table_name = 'green_taxi_data'
        
        root_path = f'{bucket_name}/{table_name}'
        
        @data_exporter
        def export_data(data1, *args, **kwargs):
            
            table = pa.Table.from_pandas(data1)
        
            gcs = pa.fs.GcsFileSystem()
        
            pq.write_to_dataset(
                table,
                root_path=root_path,
                partition_cols=['lpep_pickup_date'],
                filesystem=gcs
            )
*Homework 3*

    Q1: 840,402
    
    Q2: 0 MB for the External Table and 6.41MB for the Materialized Table
         SELECT COUNT(1) FROM silent-blade-412220.ny_taxi.green_taxi_data_h3
         GROUP BY PULocationID
        
    Q3: 1,622
        SELECT COUNT(1) FROM silent-blade-412220.ny_taxi.green_taxi_data_h3
        WHERE fare_amount = 0
    Q4: answ. 2 "Partition by lpep_pickup_datetime Cluster on PUlocationID"

        
    Q5: 12.82 MB for non-partitioned table and 1.12 MB for the partitioned table
        
        
    Q6: GCP Bucket     
        
        
    Q7: false: clustering/partitioning could increase costs of querring for smaller tables (<1GB) compared to not using those techniques.

*Homework dlt workshop*

    Q1: Sum is: 8.382332347441762
    Q2: 13th value is: 3.605551275463989
    Q3: 353
    Q4: 266

        def square_root_generator(limit):
        n = 1
        while n <= limit:
            yield n ** 0.5
            n += 1

        # Example usage:
        limit = 5
        sum = 0
        generator = square_root_generator(limit)
        
        for sqrt_value in generator:
            sum += sqrt_value
            print(sqrt_value)
        print (f"Sum is: {sum}")


*Homework risingwave workshop*

-- Q3
DROP MATERIALIZED VIEW q1

CREATE MATERIALIZED VIEW q1 AS
SELECT
        taxi_zone_pu.Zone as pickup_zone,
        count(1) as count
    FROM
        trip_data
    JOIN taxi_zone as taxi_zone_pu
        ON trip_data.PULocationID = taxi_zone_pu.location_id
    WHERE
        trip_data.tpep_pickup_datetime > ('2022-01-02 17:53:33') AND trip_data.tpep_pickup_datetime < ('2022-01-03 10:53:33')
    GROUP BY 
        pickup_zone
    ORDER BY count;

SELECT * FROM q1 order by count desc;


--Q1, Q2
WITH t AS (
    SELECT 
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        total_amount,
        tpep_dropoff_datetime-tpep_pickup_datetime AS trip_time,
        taxi_zone_PU.Zone AS pickup_zone,
        taxi_zone_DO.Zone AS dropoff_zone
    FROM trip_data
    JOIN taxi_zone AS taxi_zone_PU
        ON trip_data.PULocationID = taxi_zone_PU.location_id
    JOIN taxi_zone AS taxi_zone_DO
        ON trip_data.DOLocationID = taxi_zone_DO.location_id)   

SELECT COUNT(*), AVG(trip_time) AS trip_time_avg, MAX(trip_time), MIN(trip_time), CONCAT(pickup_zone,' / ', dropoff_zone) AS pudopair
FROM t
GROUP BY pudopair
ORDER BY trip_time_avg DESC
LIMIT 100;


