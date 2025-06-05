import { CONTRACT_ABI, CONTRACT_ADDRESS } from "@/contracts/StakeTask";
import { Chain, createPublicClient, parseEther, http } from "viem";
import { useWriteContract } from "wagmi";
import { toast } from "sonner";

export function useTaskContract(chain: Chain) {
  const { writeContract } = useWriteContract();
  const publicClient = createPublicClient({
    chain: chain,
    transport: http(),
  });

  const createTask = async (description: string, value: string) => {
    try {
      const result = await writeContract({
        address: CONTRACT_ADDRESS as `0x${string}`,
        abi: CONTRACT_ABI,
        functionName: "createTask",
        args: [description],
        value: parseEther(value),
      });

      toast.success("Tarefa criada com sucesso!");
      return result;
    } catch (error) {
      toast.error("Erro ao criar tarefa");
      throw error;
    }
  };

  const completeTask = async (taskId: string) => {
    try {
      const result = await writeContract({
        address: CONTRACT_ADDRESS as `0x${string}`,
        abi: CONTRACT_ABI,
        functionName: "completeTask",
        args: [BigInt(taskId)],
      });

      toast.success("Tarefa completada! ETH liberado 🎉");
      return result;
    } catch (error) {
      toast.error("Erro ao completar tarefa");
      throw error;
    }
  };

  const getTasks = async () => {
    const tasks = [];

    const taskCount = await publicClient.readContract({
      address: CONTRACT_ADDRESS as `0x${string}`,
      abi: CONTRACT_ABI,
      functionName: "getTasksCount",
      args: [],
    });

    for (let index = 0; index < taskCount; index++) {
      const task = await publicClient.readContract({
        address: CONTRACT_ADDRESS as `0x${string}`,
        abi: CONTRACT_ABI,
        functionName: "getTask",
        args: [BigInt(index)],
      });
      tasks.push(task);
    }
  };

  return {
    createTask,
    completeTask,
    getTasks,
  };
}
