#!/usr/bin/julia
# github.com/atille/keeper.jl
# $ julia keeper.jl --url=https://... [--exts=jpg,gif...] [--dir=downloads] [--https]
function main(args)

	# We define globaly the variables that must be affected.
	url = nothing
	extensions = nothing
	output_dir = nothing
	ssl_forced = false
	protocol = "http"
	separator = "\""
	
	# For each argument submitted, we change the variable values.
	for arg in args
		if startswith(arg, "--url=")
			url = split(arg, "--url=")[2]
		end

		# Specific extensions, or default ones bellow.
		if startswith(arg, "--exts=")
			extensions = split(arg, "--exts=")[2]
			extensions = split(extensions, ",")
		end

		# Specify the output directory where will be downloaded the found files.
		if startswith(arg, "--dir=")
			output_dir = split(arg, "--dir=")[2]
		end
		
		# If declared, will change " as the separator to ' in HTML documents.
		is startswith(arg, "--separator=")
			separator = split(arg, "--separator=")[2]
		end
	
		# If specified, we force the HTTPS for download the files (if found).
		if isequal(arg, "--https")
			ssl_forced = true
			protocol = "https"
		end

		if isequal(arg, "--help")
			getHelp()
			quit()
		end
	end

	# If the script is launched without argument, we die it.
	if isequal(url, nothing)
		println("No argument submitted.")
		quit()
	end

	# If we didn't added --exts=, so we define few default extensions.
	if isequal(extensions, nothing)
		extensions = ["jpg", "png", "gif"]
	end

	# If we didn't added --dir=/path, we define the output directory as default.
	if isequal(output_dir, nothing)
		output_dir = "scrapped_content"
	end

	# If the specified folder isn't available, we create it, and all its subs.
	isdir(output_dir) || mkdir(output_dir)
	map(x -> mkdir(string(output_dir, "/", x)), extensions)

	# We download with wget/curl/fetch the HTML content.
	f = download(url)
	data = readstring(open(f, "r"))
	elements = split(data, separator)

	# For all the elements we got with the split function, we check if this is a URL that begins
	# with the right protocol (http/https) and ends with the wanted file extensions.
	for element in elements
		for extension in extensions
			if startswith(element, protocol) && endswith(element, extension)
				println(string("[$extension] : ", element))
			
				# We generate a new name, random.
				filename = randstring(6)
				
				# We launch the file download in background and asynchronous for more speed and
				# unprocedural process.
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
