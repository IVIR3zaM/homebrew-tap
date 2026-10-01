class Planzilla < Formula
  desc "Plan, run and verify work with AI agents from Markdown plan files"
  homepage "https://github.com/IVIR3zaM/Planzilla"
  url "https://github.com/IVIR3zaM/Planzilla/releases/download/v0.1.0/planzilla-0.1.0.tar.gz"
  sha256 "cb9047772bc8ae87ffc2ffe0ecf65f3e6b07673957470d955c3651d5f3839d55"
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
