export interface ApiResponse<T = any> {
  result: T;
  resultCode: number;
}

export interface HandlerResult<T> {
  data: T;
  statusCode: number;
}

export interface Engraver {
  id: string;
  name: string;
  location: string;
  specialty: string;
  active: boolean;
}

export interface PaginationParams {
  p?: string;  // page number
  s?: string;  // page size
}

export interface PaginatedEngravers {
  engravers: Engraver[];
  page: number;
  pageSize: number;
  totalCount: number;
}

export interface HandlerResult<T = any> {
  data: T;
  statusCode: number;
}