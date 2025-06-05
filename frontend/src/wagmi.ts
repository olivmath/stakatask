import { getDefaultConfig } from "@rainbow-me/rainbowkit";
import {
  anvil,
  arbitrum,
  base,
  mainnet,
  optimism,
  polygon,
  sepolia,
} from "wagmi/chains";

export const config = getDefaultConfig({
  appName: "StakeTask",
  projectId: "557c4169c96e1ff9302e6fca8f080c09",
  chains: [mainnet, sepolia, anvil],
  ssr: true,
});
