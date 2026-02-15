# DeepRecon 

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
├─ DeepRecon                # executable script (chmod +x)
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
chmod +x DeepRecon

# Optional: move it to PATH for global usage
sudo mv DeepRecon /usr/local/bin/deeprecon

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

## Best Practices

* Ensure `GOBIN` or `GOPATH/bin` is added to PATH after installing Go-based tools:

```bash
export PATH=$PATH:$(go env GOPATH)/bin
```

* Add `DeepRecon_Results/` to `.gitignore` to avoid uploading scan output to remote.
* For large targets or many JS/URLs, increase timeouts or provide more resources (RAM/CPU).
* Always get written permission before scanning targets you don't own.

---

## Optional: Alias

```bash
# Add alias to your shell rc file
echo "alias deeprecon='/path/to/DeepRecon'" >> ~/.bashrc
source ~/.bashrc
# Run with
deeprecon example.com
```

---

## Contributing

Contributions are welcome:

1. Open an issue for suggestions or bugs.
2. Create a new branch: `feature/xxx` or `fix/yyy`.
3. Submit a Pull Request with a clear description and test steps.

---

## Responsible Disclosure

Found a vulnerability or malicious behavior? Please report it privately via GitHub issues or email before public disclosure so we can coordinate fixes.

---

## License

This project is released under the MIT License. See `LICENSE` for details.

---

## Changelog

* **v1.0** — Initial release: subdomains, httpx, katana, wayback, gau, jsecret, JS endpoint extraction, timeout per-tool.

```

---

# .gitignore

```

# Results & temporary

DeepRecon_Results/
*.tmp
*.log

# System / editor files

.DS_Store
.idea/
.vscode/
*.swp

# Binary / build artifacts

node_modules/
dist/

````

---

# LICENSE (MIT) — full text

```text
MIT License

Copyright (c) 2026 YOUR_NAME

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
````

---


