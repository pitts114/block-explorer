import axios, { AxiosResponse, AxiosStatic } from 'axios';

export interface Block {
  height: number;
  time: number;
  nTx: number;
  size: number;
  [key: string]: any;
};

export type GetBlocksResponse = Block[];

export default class BlockExplorerClient {
  private readonly _baseUrl: string;
  private readonly axiosStatic: AxiosStatic;

  constructor(baseUrl: string, axiosStatic: AxiosStatic = axios) {
    this.axiosStatic = axiosStatic;
    this._baseUrl = baseUrl;
  }

  async get(path: string): Promise<GetBlocksResponse> {
    const url = `${this._baseUrl}${path}`;
    const response: AxiosResponse<GetBlocksResponse> = await this.axiosStatic.get(url, {
      headers: {
        Accept: 'application/json',
      },
    });
    return response.data;
  }
}
