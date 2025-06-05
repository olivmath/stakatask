import { ConnectButton } from "@rainbow-me/rainbowkit";
import type { NextPage } from "next";

const Home: NextPage = () => {
  return (
    <div
      style={{
        display: "flex",
        justifyContent: "flex-end",
        padding: 12,
      }}
    >
      <ConnectButton />
      <div className="bg-primary text-primary-foreground p-4 rounded-lg">
      </div>
    </div>
  );
};

export default Home;
