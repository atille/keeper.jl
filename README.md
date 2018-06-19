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
mv keeper/src/keeper.jl /usr/bin/keeper
chmod +x /usr/bin/keeper
```
## How to use

```bash
$ keeper --url=https://domain.com
$ keeper --url=https://domain.com --exts=jpg,png
$ keeper --url=https://domain.com --exts=jpg,png --dir=domain
$ keeper --url=https://domain.com --exts=jpg,png --dir=domain --https
$ keeper --url=https://domain.com --exts=jpg,png --dir=domain --https --separator=\'
```

### Arguments

```text
--url=domain.com : set domain.com as the target domain.
(optional) --exts=jpg,png : download all the jpg and png images. Default: png, jpg, gif.
(optional) --dir=domain : create a new folder "domain" containing independant folders for each extensions. Default: scrapped_content
(optional) --https : only download the files if reached with HTTPS.
(optional) --separator=\' : will use ' as the meta separator in the HTML document. Default: "
```

## Example

```text
$ keeper --url=https://imgur.com/gallery/wEQ4oLp --exts=jpg,png,gif --dir=imgur_thread --https --separator=\"
[jpg] : https://i.imgur.com/XH1noBW.jpg
[jpg] : https://i.imgur.com/XH1noBWh.jpg
  1.688980 seconds (184.67 k allocations: 9.289 MiB)
```

## Behavior

If your connection is not as good as possible, you can encounter a specific behavior due to the @async macro which allows the wget command to be performed even if the script is now shut. If you check your process, you should be able to see a long queue of wget commands, downloading the free way the images ; wait a minute until everything is fine and you can go to the dir folder to find your files at 100% downloaded.

```bash
$ ps faux | grep keeper | grep wget
$ ps faux | grep keeper | grep wget | wc -l
$ while true ; do ps faux | grep keeper | grep wget | wc -l ; sleep 6 ; sone
```
