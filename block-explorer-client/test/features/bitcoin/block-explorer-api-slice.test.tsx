import { renderHook, waitFor } from '@testing-library/react';
import { createBlockExplorerApiSlice } from '../../../src/features/bitcoin/block-explorer-api-slice';
import BlockExplorerClient from '../../../lib/block-explorer-client/src';
import { createWrapper } from '../../test-utils';

describe('block-explorer-api hooks', () => {
  const blockExplorerClient = new BlockExplorerClient('http://localhost:3000');
  const blockExplorerApiSlice = createBlockExplorerApiSlice(blockExplorerClient);
  const { useGetBlocksQuery } = blockExplorerApiSlice;

  test('useGetBlocksQuery returns data on resolve', async () => {
    const mockData = [{ height: 1, time: 1631714400, nTx: 1, size: 1 }];
    vi.spyOn(blockExplorerClient, 'get').mockResolvedValueOnce(mockData);

    const { result } = renderHook(() => useGetBlocksQuery(), {
      wrapper: createWrapper(),
    });

    await waitFor(() => expect(result.current.data).toEqual(mockData));
  });

  test('useGetBlocksQuery returns error on reject', async () => {
    const mockError = new Error('API error');
    vi.spyOn(blockExplorerClient, 'get').mockRejectedValueOnce(mockError);

    const { result } = renderHook(() => useGetBlocksQuery(), {
      wrapper: createWrapper(),
    });

    await waitFor(() => expect(result.current.error?.message).toEqual(mockError.message));
    expect(result.current.error?.name).toEqual(mockError.name);
    expect(result.current.error?.stack).toEqual(mockError.stack);
  });
});
