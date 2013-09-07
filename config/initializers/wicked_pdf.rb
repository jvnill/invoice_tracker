unless Rails.env.production?
  WickedPdf.config = { exe_path: Rails.root.join('vendor', 'bin', 'wkhtmltopdf').to_s }
end
