return {
  -- Local Swagger UI viewer
  {
    "nvim-lua/plenary.nvim",
    config = function()
      local function setup_swagger_ui()
        local file_path = vim.fn.expand("%:p")
        local filename = vim.fn.expand("%:t")
        
        -- Create temp directory for Swagger UI
        local temp_dir = vim.fn.tempname()
        vim.fn.mkdir(temp_dir, "p")
        
        -- Copy OpenAPI file to temp directory
        local openapi_copy = temp_dir .. "/" .. filename
        vim.fn.system(string.format("cp %s %s", vim.fn.shellescape(file_path), vim.fn.shellescape(openapi_copy)))
        
        -- Create HTML with Swagger UI that loads the file
        local html_content = string.format([[
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>%s - Swagger UI</title>
    <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist@5.11.0/swagger-ui.css">
    <style>
        body { margin: 0; padding: 0; }
        #swagger-ui { padding: 20px; }
        .topbar { display: none !important; }
    </style>
</head>
<body>
    <div id="swagger-ui"></div>
    <script src="https://unpkg.com/swagger-ui-dist@5.11.0/swagger-ui-bundle.js"></script>
    <script src="https://unpkg.com/swagger-ui-dist@5.11.0/swagger-ui-standalone-preset.js"></script>
    <script>
        const url = './%s';
        
        window.onload = function() {
            window.ui = SwaggerUIBundle({
                url: url,
                dom_id: '#swagger-ui',
                deepLinking: true,
                presets: [
                    SwaggerUIBundle.presets.apis,
                    SwaggerUIStandalonePreset
                ],
                plugins: [
                    SwaggerUIBundle.plugins.DownloadUrl
                ],
                layout: "StandaloneLayout",
                tryItOutEnabled: true,
                supportedSubmitMethods: ['get', 'post', 'put', 'delete', 'patch'],
                onComplete: function() {
                    console.log("Swagger UI loaded successfully");
                }
            });
        };
    </script>
</body>
</html>
]], filename, filename)
        
        -- Write HTML file
        local html_file = temp_dir .. "/index.html"
        local file = io.open(html_file, "w")
        if file then
          file:write(html_content)
          file:close()
        end
        
        -- Use a unique port based on file path hash
        local port = 40000 + (vim.fn.str2nr(vim.fn.sha256(file_path)) % 10000)
        
        -- Kill any existing server on this port
        vim.fn.system(string.format("lsof -ti:%d | xargs kill -9 2>/dev/null", port))
        
        -- Start Python server
        local server_cmd = string.format(
          "cd %s && python3 -m http.server %d > /dev/null 2>&1 &",
          vim.fn.shellescape(temp_dir),
          port
        )
        vim.fn.system(server_cmd)
        
        -- Wait for server to start
        vim.cmd("sleep 500m")
        
        -- Open in browser
        local url = string.format("http://localhost:%d", port)
        vim.fn.system(string.format("open '%s'", url))
        
        vim.notify(string.format("Swagger UI opened at %s", url), vim.log.levels.INFO)
        
        -- Store server info for cleanup
        vim.g.swagger_servers = vim.g.swagger_servers or {}
        vim.g.swagger_servers[file_path] = { port = port, dir = temp_dir }
      end
      
      -- Stop all Swagger servers
      local function stop_swagger_servers()
        if vim.g.swagger_servers then
          for _, server in pairs(vim.g.swagger_servers) do
            vim.fn.system(string.format("lsof -ti:%d | xargs kill -9 2>/dev/null", server.port))
            vim.fn.delete(server.dir, "rf")
          end
          vim.g.swagger_servers = {}
          vim.notify("All Swagger servers stopped", vim.log.levels.INFO)
        else
          vim.notify("No Swagger servers running", vim.log.levels.WARN)
        end
      end
      
      -- Commands
      vim.api.nvim_create_user_command("SwaggerUI", setup_swagger_ui, {})
      vim.api.nvim_create_user_command("SwaggerStop", stop_swagger_servers, {})
      
      -- Keymaps
      vim.keymap.set("n", "<leader>sw", setup_swagger_ui, { desc = "Open in Swagger UI" })
      vim.keymap.set("n", "<leader>sx", stop_swagger_servers, { desc = "Stop Swagger servers" })
    end,
  },
}