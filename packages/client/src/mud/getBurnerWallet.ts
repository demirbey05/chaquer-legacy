import { Wallet } from "ethers";

export const getBurnerWallet = () => {
  let privateKey;
  if (typeof window !== "undefined") {
    // Perform localStorage action
    privateKey = localStorage.getItem("naka:burnerWallet");
  }
  if (privateKey) return new Wallet(privateKey);
  const burnerWallet = Wallet.createRandom();
  if (typeof window !== "undefined") {
    // Perform localStorage action
    localStorage.setItem("naka:burnerWallet", burnerWallet.privateKey);
  }
  return burnerWallet;
};
