# 1. Instance Template for Frontend
resource "google_compute_instance_template" "front_template" {
  name         = "frontend-template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.sub_front.id
    access_config {}
  }

  metadata_startup_script = <<-EOT
    sudo apt-get update && sudo apt-get install -y docker.io
    sudo docker run -d -p 80:80 --name frontend-web nginx
    sudo docker exec frontend-web bash -c "echo '<html><body style=\"text-align:center; background-color:#f0f2f5;\"><h1>Welcome to Cloud Forge - Frontend</h1><img src=\"https://wallpaperaccess.com/full/415510.jpg\" style=\"width:80%; border-radius:15px;\"></body></html>' > /usr/share/nginx/html/index.html"
  EOT
}

# 2. Managed Instance Group (MIG) for Frontend
resource "google_compute_instance_group_manager" "front_mig" {
  name               = "frontend-mig"
  base_instance_name = "frontend"
  target_size        = 2 # سينشئ جهازين تلقائياً
  zone               = "us-central1-a"

  version {
    instance_template = google_compute_instance_template.front_template.id
  }
}

# 3. Instance Template for Backend
resource "google_compute_instance_template" "back_template" {
  name         = "backend-template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.sub_back.id
  }

  metadata_startup_script = <<-EOT
    sudo apt-get update && sudo apt-get install -y docker.io
    sudo docker run -d -p 80:80 --name backend-api nginx
    sudo docker exec backend-api bash -c "echo '<html><body style=\"text-align:center; background-color:#1c1c1c; color:white;\"><h1>Backend Cloud Forge Node</h1><img src=\"https://wallpaperaccess.com/full/2454628.png\" style=\"width:80%; border-radius:15px;\"></body></html>' > /usr/share/nginx/html/index.html"
  EOT
}

# 4. Managed Instance Group (MIG) for Backend
resource "google_compute_instance_group_manager" "back_mig" {
  name               = "backend-mig"
  base_instance_name = "backend"
  target_size        = 1
  zone               = "us-central1-a"

  version {
    instance_template = google_compute_instance_template.back_template.id
  }
}