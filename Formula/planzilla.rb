class Planzilla < Formula
  desc "Plan, run and verify work with AI agents from Markdown plan files"
  homepage "https://github.com/IVIR3zaM/Planzilla"
  url "https://github.com/IVIR3zaM/Planzilla/releases/download/v0.3.0/planzilla-0.3.0.tar.gz"
  sha256 "d9d5b5ec64f6aac89ee7de22f68e1dfcda0e5e5ac7a8493efb507980d9599a1b"
  license "Apache-2.0"

  depends_on "python@3.13"

  def install
    libexec.install "src/planzilla"
    python = which("python3.13")
    %w[planzilla plz].each do |name|
      (bin/name).write <<~SH
        #!/bin/sh
        PYTHONPATH="#{libexec}" exec "#{python}" -m planzilla "$@"
      SH
      (bin/name).chmod 0755
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/planzilla --version")
  end
end
