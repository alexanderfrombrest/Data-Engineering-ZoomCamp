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
    Q2:
    Q3:
    Q4:
    Q5:
Q6:
