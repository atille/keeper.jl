# keeper.jl
Content scrapper developed in Julia. Download the fast way the interesting content you stumbled upon.

## How to install
### Requirements

- Julia 0.6
- Wget
- Writting permissions

### Clone this repo

```bash
git clone https://github.com/atille/keeper.jl keeper
```
## How to use

```bash
$ julia keeper.jl --url=https://domain.com
$ julia keeper.jl --url=https://domain.com --exts=jpg,png
$ julia keeper.jl --url=https://domain.com --exts=jpg,png --dir=domain
$ julia keeper.jl --url=https://domain.com --exts=jpg,png --dir=domain --https
```

### Arguments

```text
--url=domain.com : set domain.com as the target domain.
(optional) --exts=jpg,png : download all the jpg and png images. Default: png, jpg, gif.
(optional) --dir=domain : create a new folder "domain" containing independant folders for each extensions. Default: scrapped_content
(optional) --https : only download the files if reached with HTTPS.
```

## Example

```text
julia hello.jl --url=https://imgur.com/gallery/wEQ4oLp --exts=jpg,png,gif --dir=imgur_thread --https
[jpg] : https://i.imgur.com/XH1noBW.jpg
[jpg] : https://i.imgur.com/XH1noBWh.jpg
  1.688980 seconds (184.67 k allocations: 9.289 MiB)
```
