import { createApi, fakeBaseQuery } from '@reduxjs/toolkit/query/react';
import BlockExplorerClient, { Block as BlockExplorerClientBlock } from '../../../lib/block-explorer-client/src/index';

export interface Block {
  height: number;
  time: number;
  nTx: number;
  size: number;
}

export const createBlockExplorerApiSlice = (
  blockExplorerClient: BlockExplorerClient = new BlockExplorerClient('http://localhost:3000')
) => createApi({
  reducerPath: 'blockExplorerApi',
  baseQuery: fakeBaseQuery<Error>(),
  endpoints: (builder) => ({
    getBlocks: builder.query<Block[], void>({
      queryFn: async () => {
        try {
          const result = await blockExplorerClient.get('/blocks');
          return { data: result.map((block: BlockExplorerClientBlock): Block => ({
          height: block.height,
          time: block.time,
          nTx: block.nTx,
          size: block.size,
          })) };
        } catch (error: unknown) {
          if (error instanceof Error) {
            return { error: { message: error.message, name: error.name, stack: error.stack } };
          } else {
            return { error: { message: 'An unknown error occurred', name: 'UnknownError' } };
          }
        }
      }
    })
  })
});

export const blockExplorerApiSlice = createBlockExplorerApiSlice();

export default blockExplorerApiSlice.reducer;
export const { useGetBlocksQuery } = blockExplorerApiSlice;
