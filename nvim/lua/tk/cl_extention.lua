local cl_status_ok, cl = pcall(require, "codelens_extensions")
if not cl_status_ok then
    return
end

cl.setup()

