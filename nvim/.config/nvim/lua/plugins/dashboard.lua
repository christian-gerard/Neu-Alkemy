return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		-- Gothic alchemist purple highlights
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#9B59B6" })
		vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#6C3483" })

		-- Inspirational quotes about mastering a craft
		local quotes = {
			{ '"The master has failed more times than the beginner has even tried."', "-- Stephen McCranie" },
			{ '"Every artist was first an amateur."', "-- Ralph Waldo Emerson" },
			{ '"The only way to do great work is to love what you do."', "-- Steve Jobs" },
			{ '"It is not that I am so smart. It is that I stay with problems longer."', "-- Albert Einstein" },
			{ '"The impediment to action advances action. What stands in the way becomes the way."', "-- Marcus Aurelius" },
			{ '"A smooth sea never made a skilled sailor."', "-- Franklin D. Roosevelt" },
			{ '"We are what we repeatedly do. Excellence, then, is not an act, but a habit."', "-- Will Durant" },
			{ '"The man who moves a mountain begins by carrying away small stones."', "-- Confucius" },
			{ '"Simplicity is the ultimate sophistication."', "-- Leonardo da Vinci" },
			{ '"First, solve the problem. Then, write the code."', "-- John Johnson" },
			{ '"The secret of getting ahead is getting started."', "-- Mark Twain" },
			{ '"Do not wait to strike till the iron is hot, but make it hot by striking."', "-- William Butler Yeats" },
			{ '"Fall seven times, stand up eight."', "-- Japanese Proverb" },
			{ '"Patience is bitter, but its fruit is sweet."', "-- Aristotle" },
			{ '"The best time to plant a tree was 20 years ago. The second best time is now."', "-- Chinese Proverb" },
			{ '"If you want to go fast, go alone. If you want to go far, go together."', "-- African Proverb" },
			{ '"An expert is a person who has made all the mistakes that can be made in a very narrow field."', "-- Niels Bohr" },
			{ '"The more I practice, the luckier I get."', "-- Gary Player" },
			{ '"Perfection is not attainable, but if we chase it we can catch excellence."', "-- Vince Lombardi" },
			{ '"He who is not courageous enough to take risks will accomplish nothing in life."', "-- Muhammad Ali" },
			{ '"The scariest moment is always just before you start."', "-- Stephen King" },
			{ '"Knowing is not enough; we must apply. Willing is not enough; we must do."', "-- Bruce Lee" },
			{ '"Make everything as simple as possible, but not simpler."', "-- Albert Einstein" },
			{ '"Have no fear of perfection — you\'ll never reach it."', "-- Salvador Dali" },
			{ '"The only limit to our realization of tomorrow is our doubts of today."', "-- Franklin D. Roosevelt" },
			{ '"Stay hungry. Stay foolish."', "-- Stewart Brand" },
			{ '"I am always doing that which I cannot do, in order that I may learn how to do it."', "-- Pablo Picasso" },
			{ '"Code is like humor. When you have to explain it, it\'s bad."', "-- Cory House" },
			{ '"There is nothing impossible to him who will try."', "-- Alexander the Great" },
			{ '"I am not afraid of an army of lions led by a sheep; I am afraid of an army of sheep led by a lion."', "-- Alexander the Great" },
			{ '"Remember, upon the conduct of each depends the fate of all."', "-- Alexander the Great" },
			{ '"I would rather live a short life of glory than a long one of obscurity."', "-- Alexander the Great" },
			{ '"Through every generation of the human race there has been a constant war, a war with fear."', "-- Alexander the Great" },
		}

		math.randomseed(os.time())
		local quote = quotes[math.random(#quotes)]

		-- Build quote box
		local text = quote[1]
		local author = quote[2]
		-- Add letter spacing for a "larger" feel
		local function space_out(s)
			local chars = vim.fn.split(s, "\\zs")
			return table.concat(chars, " ")
		end
		local spaced_text = space_out(text)
		local spaced_author = space_out(author)
		local max_len = math.max(#spaced_text, #spaced_author)
		local box_width = max_len + 6
		local function pad_line(s, width)
			local pad = width - #s - 6
			if pad < 0 then pad = 0 end
			return "  ║  " .. s .. string.rep(" ", pad) .. "  ║"
		end
		local top = "  ╔" .. string.rep("═", box_width - 2) .. "╗"
		local empty = "  ║" .. string.rep(" ", box_width - 2) .. "║"
		local bottom = "  ╚" .. string.rep("═", box_width - 2) .. "╝"

		local footer = {
			"",
			top,
			empty,
			pad_line(spaced_text, box_width),
			empty,
			pad_line(spaced_author, box_width),
			empty,
			bottom,
			"",
		}

		local git_handle = io.popen("git -C " .. vim.fn.getcwd() .. " status --short 2>/dev/null")
		if git_handle then
			local result = git_handle:read("*a")
			git_handle:close()
			table.insert(footer, "  ◆ Git Status ◆")
			local branch_handle = io.popen("git -C " .. vim.fn.getcwd() .. " branch --show-current 2>/dev/null")
			if branch_handle then
				local branch = branch_handle:read("*l")
				branch_handle:close()
				if branch and branch ~= "" then
					table.insert(footer, "  Branch: " .. branch)
				end
			end
			table.insert(footer, "")
			if result and result ~= "" then
				for line in result:gmatch("[^\r\n]+") do
					table.insert(footer, "  " .. line)
				end
			else
				table.insert(footer, "  Clean")
			end
			table.insert(footer, "")
		end

		require("dashboard").setup({
			theme = "hyper",
			config = {
				header = {
					"                                                                                                    ",
					"        ☽ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ☾              ",
					"                                                                                                    ",
					"         ███╗   ██╗███████╗██╗   ██╗      █████╗ ██╗     ██╗  ██╗███████╗███╗   ███╗██╗   ██╗       ",
					"         ████╗  ██║██╔════╝██║   ██║     ██╔══██╗██║     ██║ ██╔╝██╔════╝████╗ ████║╚██╗ ██╔╝       ",
					"         ██╔██╗ ██║█████╗  ██║   ██║     ███████║██║     █████╔╝ █████╗  ██╔████╔██║ ╚████╔╝        ",
					"         ██║╚██╗██║██╔══╝  ██║   ██║     ██╔══██║██║     ██╔═██╗ ██╔══╝  ██║╚██╔╝██║  ╚██╔╝         ",
					"         ██║ ╚████║███████╗╚██████╔╝     ██║  ██║███████╗██║  ██╗███████╗██║ ╚═╝ ██║   ██║          ",
					"         ╚═╝  ╚═══╝╚══════╝ ╚═════╝      ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝   ╚═╝       ",
					"                                                                                                    ",
					"        ☽ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ◆ ─── ∴ ─── ☾              ",
					"                                            ☿  ⚗  ☿                                                ",
					"                                                                                                    ",
				},
				shortcut = {},
				project = { enable = false },
				mru = { enable = false },
				footer = footer,
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
