const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("Register", (m) => {
  const apollo = m.contract("RegisterDisaster");
  return { apollo };
});