class Figfig < Formula
  desc "Local autocomplete and inline suggestions for your existing terminal"
  homepage "https://github.com/trancore/figfig"
  url "https://github.com/trancore/figfig/releases/download/v0.0.1/figfig-0.0.1-source.tar.gz"
  sha256 "b9354739cca05f0d008533e967fdac35c47b70674cbdee63c19a509bd49db863"
  license "MIT"

  depends_on "node" => :build
  depends_on "pnpm@12" => :build
  depends_on "rust" => :build
  depends_on macos: :ventura

  def install
    ENV["MACOSX_DEPLOYMENT_TARGET"] = "13.0"
    ENV["PNPM_HOME"] = (buildpath/".pnpm").to_s
    ENV["XDG_DATA_HOME"] = (buildpath/".local/share").to_s
    ENV["XDG_CACHE_HOME"] = (buildpath/".cache").to_s
    ENV.prepend_path "PATH", formula_opt_bin("pnpm@12")
    system "pnpm", "install", "--frozen-lockfile", "--ignore-scripts", "--store-dir", buildpath/".pnpm-store"
    system "pnpm", "run", "build:release"
    bin.install "target/release/figfig"
    libexec.install "target/release/bundle/macos/figfig.app"
  end

  def caveats
    <<~EOS
      Set up zsh integration:
        figfig setup
      Allow terminal cursor positioning once:
        figfig permissions
      Open a new terminal. The popup helper starts automatically in the background.
      Configure suggestions from the command line:
        figfig config

      Enable figfig in System Settings > Privacy & Security > Accessibility.
      The private popup helper is built locally with an ad-hoc signature. It is not notarized.
      After upgrades, macOS may ask you to grant Accessibility again.
    EOS
  end

  test do
    assert_path_exists libexec/"figfig.app/Contents/MacOS/figfig-desktop"
    system "/usr/bin/codesign", "--verify", "--deep", "--strict", libexec/"figfig.app"
    assert_match version.to_s, shell_output("#{bin}/figfig --version")
    result = JSON.parse(shell_output("#{bin}/figfig complete 'git ch' '#{testpath}'"))
    assert result.fetch("candidates").any? { |candidate| candidate.fetch("label") == "checkout" }
    assert_match "_figfig_receive", shell_output("#{bin}/figfig init zsh")
  end
end
