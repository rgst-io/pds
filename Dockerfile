ARG NODE_VERSION=unset
FROM node:${NODE_VERSION}-alpine3.20 AS build
WORKDIR /app
COPY ./service ./
RUN corepack enable && corepack use pnpm
RUN pnpm install --production --frozen-lockfile

# Uses assets from build stage to reduce build size
FROM node:${NODE_VERSION}-alpine3.20
LABEL org.opencontainers.image.source=https://github.com/rgst-io/pds
LABEL org.opencontainers.image.description="AT Protocol PDS"
LABEL org.opencontainers.image.licenses=MIT
EXPOSE 3000
ENV PDS_PORT=3000
ENV NODE_ENV=production

# Avoid zombie processes, handle signal forwarding
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "--enable-source-maps", "index.js"]

RUN apk add --no-cache --update dumb-init

WORKDIR /app
COPY --from=build /app /app