resource "google_compute_network" "vpc_front" {
  name                    = "vpc-frontend"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub_front" {
  name          = "subnet-frontend"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_front.id
}

resource "google_compute_network" "vpc_back" {
  name                    = "vpc-backend"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "sub_back" {
  name          = "subnet-backend"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_back.id
}

resource "google_compute_network_peering" "p1" {
  name         = "f-to-b"
  network      = google_compute_network.vpc_front.self_link
  peer_network = google_compute_network.vpc_back.self_link
}

resource "google_compute_network_peering" "p2" {
  name         = "b-to-f"
  network      = google_compute_network.vpc_back.self_link
  peer_network = google_compute_network.vpc_front.self_link
}

resource "google_compute_firewall" "fw_front" {
  name    = "fw-front"
  network = google_compute_network.vpc_front.name
  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "fw_back" {
  name    = "fw-back"
  network = google_compute_network.vpc_back.name
  allow {
    protocol = "tcp"
    ports    = ["22", "5000", "80"]
  }
  source_ranges = ["10.0.1.0/24"]
}