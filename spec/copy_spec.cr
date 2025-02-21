require "./spec_helper"
require "../src/modules/functions/generate_hash.cr"

describe "run_cmd" do
  it "runs a command in shell and returns the output" do
    output = Hashbrown.run_cmd("echo", ["test"])

    output.should eq("test\n")
  end

  it "gets hashes from file" do
    path = Path["./spec/test.txt"].expand(home: true)
    hashes = [] of String
    ["sha256sum", "md5sum", "sha1sum"].each do |x|
      output = Hashbrown.run_cmd(x, [path.to_s]).split(" ")[0]
      hashes << output
    end

    hashes.should eq(["08e3dfc089e66c44ae8abd3476b0f810f11f4cfc2ab925f1607c7df21345d639", "f7e3f382f0382147661c82af20e274e8", "c8f0b71214e8164aa69419b7ac0bcd8a74f529a6"])
  end
end
