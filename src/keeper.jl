# github.com/atille/keeper.jl
# $ julia keeper.jl --url=https://... [--exts=jpg,gif...] [--dir=downloads] [--https]
function main(args)

	url = nothing
	extensions = nothing
	output_dir = nothing
	ssl_forced = false
	protocol = "http"

	for arg in args
		if startswith(arg, "--url=")
			url = split(arg, "--url=")[2]
		end

		if startswith(arg, "--exts=")
			extensions = split(arg, "--exts=")[2]
			extensions = split(extensions, ",")
		end

		if startswith(arg, "--dir=")
			output_dir = split(arg, "--dir=")[2]
		end

		if isequal(arg, "--https")
			ssl_forced = true
			protocol = "https"
		end

		if isequal(arg, "--help")
			getHelp()
			quit()
		end
	end

	if isequal(url, nothing)
		println("No argument submitted.")
		quit()
	end

	if isequal(extensions, nothing)
		extensions = ["jpg", "png", "gif"]
	end

	if isequal(output_dir, nothing)
		output_dir = "scrapped_content"
	end

	isdir(output_dir) || mkdir(output_dir)
	map(x -> mkdir(string(output_dir, "/", x)), extensions)

	f = download(url)
	data = readstring(open(f, "r"))
	elements = split(data, "\"")


	for element in elements
		for extension in extensions
			if startswith(element, protocol) && endswith(element, extension)
				println(string("[$extension] : ", element))
				filename = randstring(6)
				@async run(`wget -O $output_dir/$extension/$filename.$extension $element -q`)
			end
		end
	end
end

function getHelp()

	println("Keeper | Content scrapper developed in Julia - POC")
	println(" - --url=\t define the url to scrap. Not optional.")
	println(" - --https\t files must be loaded with https. Optional.")
	println(" - --dir=\t directory of saved files.")
	println(" - --exts=\t separated with commas, target extensions. Default: jpg, gif, png.")
	println(" - --help\t display this page.")
end

@time main(ARGS)
