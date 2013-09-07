WickedPdf.config = { exe_path: Rails.root.join('vendor', 'bin', Rails.env.production? ? 'wkhtmltopdf-i386' : 'wkhtmltopdf').to_s }
