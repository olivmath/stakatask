export interface Task {
  id: string;
  title: string;
  value: string;
  completed: boolean;
  createdAt: Date;
  txHash?: string;
}

export interface TaskContractData {
  id: bigint;
  description: string;
  value: bigint;
  completed: boolean;
  creator: string;
}
