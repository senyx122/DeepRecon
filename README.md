# DeepRecon 

<p align="center">
  <img src="https://i.ibb.co/Z6gBQLKp/unnamed-Edited.jpg" width="400">
</p>

**DeepRecon — Advanced Bash Recon Automation Tool**

DeepRecon is a powerful, all-in-one Bash-based reconnaissance automation tool designed for security researchers and authorized pentesters. It streamlines subdomain enumeration, live host detection, URL discovery, JavaScript secret scanning, and API endpoint extraction — then organizes results in a clean, structured output folder for quick analysis.


---

## Features

- **Subdomain Enumeration:** `subfinder`, `assetfinder`, `findomain`  
- **Live Host Detection:** `httpx`  
- **URL Discovery:** `katana`, `waybackurls`, `gau`  
- **JavaScript Secret Scanning:** `jsecret`  
- **API Endpoint Extraction** from JS files (grep-based + optional `linkfinder`)  
- Automatic installation of required tools (best-effort)  
- Timeout control per tool using `-l` and `-t` options  
- Organized output in `DeepRecon_Results/<target>/`  

---

## Requirements

- Linux / WSL / macOS (Bash v4+ recommended)  
- Bash shell  
- External tools (script tries to auto-install if possible):
  - `go` (for Go-based tools)
  - `subfinder`, `assetfinder`, `findomain`, `httpx`, `katana`, `waybackurls`, `gau`, `jsecret`
  - `curl`, `md5sum` (usually pre-installed)  
- `sudo` permissions (for automatic installation into system paths)

> **Note:** Installing Go (`golang`) is required for the script to `go install` the Go-based tools.

---

## Project Structure

```

DeepRecon/
├─ deeprecon                # executable script (chmod +x)
├─ README.md
├─ .gitignore
├─ LICENSE
└─ examples/
└─ sample-config.sh

````

---

## Installation (Local)

```bash
# Clone your repo (replace with your repo URL)
git clone https://github.com/senyx122/DeepRecon.git
cd DeepRecon

# Make the script executable
chmod +x deeprecon

# Optional: move it to PATH for global usage
sudo mv deeprecon /usr/local/bin/deeprecon

# Test
deeprecon -h
````

---

## Usage

```bash
# Syntax
./DeepRecon [-l tool1 tool2 ...] [-t timeout] domain.com

# Examples
./DeepRecon example.com
./DeepRecon -l gau katana -t 5 example.com   # Apply 5-minute timeout to gau & katana
```

### Main Options

* `-l, --limit`
  Specify tools to apply a timeout. Example: `-l gau katana`
* `-t, --timeout`
  Timeout value (if numeric only, interpreted as minutes). Examples: `5`, `30s`, `10m`
* `-h, --help`
  Show usage information

---

## Output Location

Default output folder: `DeepRecon_Results` in the directory where the script is run.

Example structure:

```
DeepRecon_Results/
└─ example.com/
   ├─ subs/
   │  ├─ subfinder.txt
   │  ├─ assetfinder.txt
   │  └─ all_subs.txt
   ├─ urls/
   │  ├─ katana.txt
   │  ├─ wayback.txt
   │  └─ all_urls.txt
   └─ js/
      ├─ js_links.txt
      └─ endpoints/
         ├─ all_endpoints.txt
         └─ files/
```

---

## Configurable Variables

You can change defaults in the script header:

* `OUT_BASE` — Output directory (e.g., `~/ReconResults`)
* `THREADS` — Number of threads for tools like `httpx`
* `TIMEOUT_DURATION` — Default timeout used for selected tools
* `REQUIRED_TOOLS` — Array of tools the script checks/installs automatically

---



