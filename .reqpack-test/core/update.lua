return {
  name = "nix update",
  request = {
    action = "update",
    system = "nix",
    packages = {
      { name = "delta" }
    },
  },
  fakeExec = {
    {
      match = "command -v 'nix' >/dev/null 2>&1",
      exitCode = 0,
      stdout = "",
      stderr = "",
      success = true,
    },
    {
      match = "nix profile list --json --no-pretty",
      exitCode = 0,
      stdout = "{\"version\":3,\"elements\":{\"delta\":{\"active\":true,\"attrPath\":\"legacyPackages.x86_64-linux.delta\",\"originalUrl\":\"flake:nixpkgs\",\"storePaths\":[\"/nix/store/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa-delta-1.0.0\"],\"url\":\"github:NixOS/nixpkgs/123\"}}}\n",
      stderr = "",
      success = true,
    },
    {
      match = "nix profile upgrade 'delta'",
      exitCode = 0,
      stdout = "upgraded\n",
      stderr = "",
      success = true,
    }
  },
  expect = {
    success = true,
    commands = {
      "nix profile list --json --no-pretty",
      "nix profile upgrade 'delta'"
    },
    events = { "updated", "success" },
  }
}
