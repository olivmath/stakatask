// Endereço do contrato (você vai atualizar depois do deploy)
export const CONTRACT_ADDRESS = "0x0000000000000000000000000000000000000000";

// ABI simplificada do contrato
export const CONTRACT_ABI = [
  {
    inputs: [{ name: "description", type: "string" }],
    name: "createTask",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [{ name: "taskId", type: "uint256" }],
    name: "completeTask",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [{ name: "taskId", type: "uint256" }],
    name: "getTask",
    outputs: [
      { name: "description", type: "string" },
      { name: "value", type: "uint256" },
      { name: "completed", type: "bool" },
      { name: "creator", type: "address" },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getTasksCount",
    outputs: [{ name: "", type: "uint256", internalType: "uint256" }],
    stateMutability: "view",
    type: "function",
  },
] as const;
