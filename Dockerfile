FROM node:24.10.0

WORKDIR /app

# Install dependencies (this step is cached as long as the dependencies don't change)
COPY package.json pnpm-lock.yaml ./

#RUN npm install -g corepack@latest

#RUN corepack enable pnpm && pnpm install
RUN npm install -g pnpm && pnpm install

# Copy the rest of your app's source code
COPY . .

# Expose the port the app runs on
EXPOSE 5173

ARG VITE_LOG_LEVEL=debug
ARG DEFAULT_NUM_CTX=32768

ENV VITE_LOG_LEVEL=${VITE_LOG_LEVEL} \
    DEFAULT_NUM_CTX=${DEFAULT_NUM_CTX} \
    RUNNING_IN_DOCKER=true

RUN mkdir -p ${WORKDIR}/run
CMD pnpm run dev --host 0.0.0.0