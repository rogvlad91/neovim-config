return {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    config = function()
        local SymbolKind = vim.lsp.protocol.SymbolKind
        local function text_format(symbol)
            local res = {}

            -- Indicator that shows if there are any other symbols in the same line
            local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

            if symbol.references then
                local usage = symbol.references <= 1 and "usage" or "usages"
                local num = symbol.references == 0 and "no" or symbol.references
                table.insert(res, { "󰌹 ", "SymbolUsageRef" })
                table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
            end

            if symbol.definition then
                if #res > 0 then
                    table.insert(res, { " ", "NonText" })
                end
                table.insert(res, { "󰳽 ", "SymbolUsageDef" })
                table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
            end

            if symbol.implementation then
                if #res > 0 then
                    table.insert(res, { " ", "NonText" })
                end
                table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
                table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
            end

            if stacked_functions_content ~= "" then
                if #res > 0 then
                    table.insert(res, { " ", "NonText" })
                end
                table.insert(res, { " ", "SymbolUsageImpl" })
                table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
            end

            return res
        end

        require("symbol-usage").setup({
            kinds = {
                SymbolKind.Function,
                SymbolKind.Method,
                SymbolKind.Struct,
                SymbolKind.Interface,
                SymbolKind.Class,
            },
            references = {
                enabled = true,
                include_declaration = false,
            },
            implementation = {
                enabled = true,
            },
            vt_position = "end_of_line",
            text_format = text_format,
        })
    end
}
