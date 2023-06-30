# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2023-06-30

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge` - `v0.0.7`](#edge---v007)
 - [`netlify_edge` - `v0.0.1-dev.14`](#netlify_edge---v001-dev14)
 - [`supabase_functions` - `v0.0.2+4`](#supabase_functions---v0024)
 - [`cloudflare_workers` - `v0.0.4+4`](#cloudflare_workers---v0044)
 - [`vercel_edge` - `v0.0.4+4`](#vercel_edge---v0044)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.14`
 - `supabase_functions` - `v0.0.2+4`
 - `cloudflare_workers` - `v0.0.4+4`
 - `vercel_edge` - `v0.0.4+4`

---

#### `edge` - `v0.0.7`

 - **FEAT**: add `edge.yaml` support + supabase config. ([8134137d](https://github.com/invertase/dart_edge/commit/8134137d28e66871ae03514e1e7c5284b26e600d))


## 2023-05-22

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge_runtime` - `v0.0.4+2`](#edge_runtime---v0042)
 - [`netlify_edge` - `v0.0.1-dev.13`](#netlify_edge---v001-dev13)
 - [`supabase_functions` - `v0.0.2+3`](#supabase_functions---v0023)
 - [`deno_deploy` - `v0.0.1-dev.6`](#deno_deploy---v001-dev6)
 - [`edge_http_client` - `v0.0.1+3`](#edge_http_client---v0013)
 - [`vercel_edge` - `v0.0.4+3`](#vercel_edge---v0043)
 - [`cloudflare_workers` - `v0.0.4+3`](#cloudflare_workers---v0043)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.13`
 - `supabase_functions` - `v0.0.2+3`
 - `deno_deploy` - `v0.0.1-dev.6`
 - `edge_http_client` - `v0.0.1+3`
 - `vercel_edge` - `v0.0.4+3`
 - `cloudflare_workers` - `v0.0.4+3`

---

#### `edge_runtime` - `v0.0.4+2`

 - **FIX**: cache reader to prevent locking ([#41](https://github.com/invertase/dart_edge/issues/41)). ([30f96df8](https://github.com/invertase/dart_edge/commit/30f96df858ec96462af1b4239c6b45b835e888cc))


## 2023-05-02

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge` - `v0.0.6+1`](#edge---v0061)
 - [`edge_http_client` - `v0.0.1+2`](#edge_http_client---v0012)
 - [`vercel_edge` - `v0.0.4+2`](#vercel_edge---v0042)
 - [`cloudflare_workers` - `v0.0.4+2`](#cloudflare_workers---v0042)
 - [`netlify_edge` - `v0.0.1-dev.12`](#netlify_edge---v001-dev12)
 - [`supabase_functions` - `v0.0.2+2`](#supabase_functions---v0022)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `vercel_edge` - `v0.0.4+2`
 - `cloudflare_workers` - `v0.0.4+2`
 - `netlify_edge` - `v0.0.1-dev.12`
 - `supabase_functions` - `v0.0.2+2`

---

#### `edge` - `v0.0.6+1`

 - **FIX**(supabase_functions): compile code when no dev flag is provided. ([c9c0fe3b](https://github.com/invertase/dart_edge/commit/c9c0fe3b3cd3496ce3fa3b7dab7f7d4a787d963e))

#### `edge_http_client` - `v0.0.1+2`

 - **FIX**(edge_http_client): fix invalid content length value in client. ([70d53268](https://github.com/invertase/dart_edge/commit/70d53268fbcca6cd076968c9a30818104712bb05))


## 2023-04-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge_http_client` - `v0.0.1+1`](#edge_http_client---v0011)
 - [`edge_runtime` - `v0.0.4+1`](#edge_runtime---v0041)
 - [`netlify_edge` - `v0.0.1-dev.11`](#netlify_edge---v001-dev11)
 - [`cloudflare_workers` - `v0.0.4+1`](#cloudflare_workers---v0041)
 - [`deno_deploy` - `v0.0.1-dev.5`](#deno_deploy---v001-dev5)
 - [`vercel_edge` - `v0.0.4+1`](#vercel_edge---v0041)
 - [`supabase_functions` - `v0.0.2+1`](#supabase_functions---v0021)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.11`
 - `cloudflare_workers` - `v0.0.4+1`
 - `deno_deploy` - `v0.0.1-dev.5`
 - `vercel_edge` - `v0.0.4+1`
 - `supabase_functions` - `v0.0.2+1`

---

#### `edge_http_client` - `v0.0.1+1`

 - **FIX**: fix invalid content length value in client. ([70d53268](https://github.com/invertase/dart_edge/commit/70d53268fbcca6cd076968c9a30818104712bb05))

#### `edge_runtime` - `v0.0.4+1`

 - **FIX**: fix invalid content length value in client. ([70d53268](https://github.com/invertase/dart_edge/commit/70d53268fbcca6cd076968c9a30818104712bb05))


## 2023-04-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cloudflare_workers` - `v0.0.4`](#cloudflare_workers---v004)
 - [`deno_deploy` - `v0.0.1-dev.4`](#deno_deploy---v001-dev4)
 - [`edge_runtime` - `v0.0.4`](#edge_runtime---v004)
 - [`netlify_edge` - `v0.0.1-dev.10`](#netlify_edge---v001-dev10)
 - [`supabase_functions` - `v0.0.2`](#supabase_functions---v002)
 - [`vercel_edge` - `v0.0.4`](#vercel_edge---v004)
 - [`edge_http_client` - `v0.0.1+1`](#edge_http_client---v0011)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `edge_http_client` - `v0.0.1+1`

---

#### `cloudflare_workers` - `v0.0.4`

 - **FEAT**: add edge_http_client ([#20](https://github.com/invertase/dart_edge/issues/20)). ([7526a765](https://github.com/invertase/dart_edge/commit/7526a765bb067cb092621ce4525df3c2a6e8bf29))

#### `deno_deploy` - `v0.0.1-dev.4`

 - **FEAT**: add edge_http_client ([#20](https://github.com/invertase/dart_edge/issues/20)). ([7526a765](https://github.com/invertase/dart_edge/commit/7526a765bb067cb092621ce4525df3c2a6e8bf29))

#### `edge_runtime` - `v0.0.4`

 - **FEAT**: add edge_http_client ([#20](https://github.com/invertase/dart_edge/issues/20)). ([7526a765](https://github.com/invertase/dart_edge/commit/7526a765bb067cb092621ce4525df3c2a6e8bf29))

#### `netlify_edge` - `v0.0.1-dev.10`

 - **FEAT**: add edge_http_client ([#20](https://github.com/invertase/dart_edge/issues/20)). ([7526a765](https://github.com/invertase/dart_edge/commit/7526a765bb067cb092621ce4525df3c2a6e8bf29))

#### `supabase_functions` - `v0.0.2`

 - **FEAT**: add edge_http_client ([#20](https://github.com/invertase/dart_edge/issues/20)). ([7526a765](https://github.com/invertase/dart_edge/commit/7526a765bb067cb092621ce4525df3c2a6e8bf29))

#### `vercel_edge` - `v0.0.4`

 - **FEAT**: add edge_http_client ([#20](https://github.com/invertase/dart_edge/issues/20)). ([7526a765](https://github.com/invertase/dart_edge/commit/7526a765bb067cb092621ce4525df3c2a6e8bf29))


## 2023-04-04

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge` - `v0.0.6`](#edge---v006)
 - [`edge_runtime` - `v0.0.3+1`](#edge_runtime---v0031)
 - [`netlify_edge` - `v0.0.1-dev.9`](#netlify_edge---v001-dev9)
 - [`vercel_edge` - `v0.0.3+2`](#vercel_edge---v0032)
 - [`cloudflare_workers` - `v0.0.3+2`](#cloudflare_workers---v0032)
 - [`supabase_functions` - `v0.0.1+1`](#supabase_functions---v0011)
 - [`deno_deploy` - `v0.0.1-dev.3`](#deno_deploy---v001-dev3)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.9`
 - `vercel_edge` - `v0.0.3+2`
 - `cloudflare_workers` - `v0.0.3+2`
 - `supabase_functions` - `v0.0.1+1`
 - `deno_deploy` - `v0.0.1-dev.3`

---

#### `edge` - `v0.0.6`

 - **FIX**: register supabase new command. ([66fdd085](https://github.com/invertase/dart_edge/commit/66fdd0857d2d491460fed8f906b0cb3263c93a21))
 - **FEAT**: add supabase_functions new command. ([1a0583ef](https://github.com/invertase/dart_edge/commit/1a0583efe9e45bdcf921895696694ff27c213b04))

#### `edge_runtime` - `v0.0.3+1`

 - **FIX**: patch location.href global ([#19](https://github.com/invertase/dart_edge/issues/19)). ([fd8ed116](https://github.com/invertase/dart_edge/commit/fd8ed116ec22c410bb101be36296be8915888c7a))


## 2023-04-04

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`supabase_functions` - `v0.0.1`](#supabase_functions---v001)

---

#### `supabase_functions` - `v0.0.1`


## 2023-02-22

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`deno_deploy` - `v0.0.1-dev.2`](#deno_deploy---v001-dev2)
 - [`edge_runtime` - `v0.0.3`](#edge_runtime---v003)
 - [`supabase_functions` - `v0.0.1-dev.3`](#supabase_functions---v001-dev3)
 - [`cloudflare_workers` - `v0.0.3+1`](#cloudflare_workers---v0031)
 - [`netlify_edge` - `v0.0.1-dev.8`](#netlify_edge---v001-dev8)
 - [`vercel_edge` - `v0.0.3+1`](#vercel_edge---v0031)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `supabase_functions` - `v0.0.1-dev.3`
 - `cloudflare_workers` - `v0.0.3+1`
 - `netlify_edge` - `v0.0.1-dev.8`
 - `vercel_edge` - `v0.0.3+1`

---

#### `deno_deploy` - `v0.0.1-dev.2`

 - **FEAT**: add Iterator / AsyncIterator interop. ([b23b4a4f](https://github.com/invertase/dart_edge/commit/b23b4a4ff1ab781744b4480d0fbfd286343205f5))

#### `edge_runtime` - `v0.0.3`

 - **FEAT**: add Iterator / AsyncIterator interop. ([b23b4a4f](https://github.com/invertase/dart_edge/commit/b23b4a4ff1ab781744b4480d0fbfd286343205f5))


## 2023-02-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cloudflare_workers` - `v0.0.3`](#cloudflare_workers---v003)
 - [`deno_deploy` - `v0.0.1-dev.1`](#deno_deploy---v001-dev1)
 - [`edge` - `v0.0.5`](#edge---v005)
 - [`edge_runtime` - `v0.0.2`](#edge_runtime---v002)
 - [`netlify_edge` - `v0.0.1-dev.7`](#netlify_edge---v001-dev7)
 - [`supabase_functions` - `v0.0.1-dev.2`](#supabase_functions---v001-dev2)
 - [`vercel_edge` - `v0.0.3`](#vercel_edge---v003)

---

#### `cloudflare_workers` - `v0.0.3`

 - **FEAT**: Deno deploy api. ([235f4748](https://github.com/invertase/dart_edge/commit/235f4748b0a8dc4cf4240f0b91b230bbabc9004a))

#### `deno_deploy` - `v0.0.1-dev.1`

 - **FEAT**: update deno_deploy implementation. ([5c855c65](https://github.com/invertase/dart_edge/commit/5c855c6524d4aba5e7304712d20854417adadd7d))
 - **FEAT**: Deno deploy api. ([235f4748](https://github.com/invertase/dart_edge/commit/235f4748b0a8dc4cf4240f0b91b230bbabc9004a))

#### `edge` - `v0.0.5`

 - **FEAT**: add working supabase example. ([c9544bb0](https://github.com/invertase/dart_edge/commit/c9544bb0a408a25cc977017ecae74ed06a92f3d4))

#### `edge_runtime` - `v0.0.2`

 - **FEAT**: Deno deploy api. ([235f4748](https://github.com/invertase/dart_edge/commit/235f4748b0a8dc4cf4240f0b91b230bbabc9004a))

#### `netlify_edge` - `v0.0.1-dev.7`

 - **FEAT**: Deno deploy api. ([235f4748](https://github.com/invertase/dart_edge/commit/235f4748b0a8dc4cf4240f0b91b230bbabc9004a))

#### `supabase_functions` - `v0.0.1-dev.2`

 - **FEAT**: update deno_deploy implementation. ([5c855c65](https://github.com/invertase/dart_edge/commit/5c855c6524d4aba5e7304712d20854417adadd7d))
 - **FEAT**: add working supabase example. ([c9544bb0](https://github.com/invertase/dart_edge/commit/c9544bb0a408a25cc977017ecae74ed06a92f3d4))

#### `vercel_edge` - `v0.0.3`

 - **FEAT**: add working supabase example. ([c9544bb0](https://github.com/invertase/dart_edge/commit/c9544bb0a408a25cc977017ecae74ed06a92f3d4))


## 2023-02-19

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cloudflare_workers` - `v0.0.2+5`](#cloudflare_workers---v0025)
 - [`edge` - `v0.0.4+1`](#edge---v0041)
 - [`edge_runtime` - `v0.0.1+4`](#edge_runtime---v0014)
 - [`netlify_edge` - `v0.0.1-dev.6`](#netlify_edge---v001-dev6)
 - [`vercel_edge` - `v0.0.2+5`](#vercel_edge---v0025)

---

#### `cloudflare_workers` - `v0.0.2+5`

 - **REFACTOR**: prefer named arguments on DO/KV apis. ([c6e07055](https://github.com/invertase/dart_edge/commit/c6e0705553b1607637fcdd21ee7b316a29dbd2ca))
 - **REFACTOR**: update cli implementation ([#18](https://github.com/invertase/dart_edge/issues/18)). ([86802207](https://github.com/invertase/dart_edge/commit/868022075012814679e68a3a3e48003068db6bb6))

#### `edge` - `v0.0.4+1`

 - **REFACTOR**: prefer named arguments on DO/KV apis. ([c6e07055](https://github.com/invertase/dart_edge/commit/c6e0705553b1607637fcdd21ee7b316a29dbd2ca))
 - **REFACTOR**: update cli implementation ([#18](https://github.com/invertase/dart_edge/issues/18)). ([86802207](https://github.com/invertase/dart_edge/commit/868022075012814679e68a3a3e48003068db6bb6))
 - **REFACTOR**: extract cloudflare_workers logic to standalone class. ([4ab0c13c](https://github.com/invertase/dart_edge/commit/4ab0c13cd62d83bf52067a57ae4f06444aec1c42))

#### `edge_runtime` - `v0.0.1+4`

 - **REFACTOR**: prefer named arguments on DO/KV apis. ([c6e07055](https://github.com/invertase/dart_edge/commit/c6e0705553b1607637fcdd21ee7b316a29dbd2ca))
 - **REFACTOR**: update cli implementation ([#18](https://github.com/invertase/dart_edge/issues/18)). ([86802207](https://github.com/invertase/dart_edge/commit/868022075012814679e68a3a3e48003068db6bb6))
 - **FIX**: use default ResponseInit values for anonymous delegate. ([c24142c1](https://github.com/invertase/dart_edge/commit/c24142c171878e7bfab025bc74c8d4a11358f9da))

#### `netlify_edge` - `v0.0.1-dev.6`

 - **REFACTOR**: prefer named arguments on DO/KV apis. ([c6e07055](https://github.com/invertase/dart_edge/commit/c6e0705553b1607637fcdd21ee7b316a29dbd2ca))
 - **REFACTOR**: update cli implementation ([#18](https://github.com/invertase/dart_edge/issues/18)). ([86802207](https://github.com/invertase/dart_edge/commit/868022075012814679e68a3a3e48003068db6bb6))

#### `vercel_edge` - `v0.0.2+5`

 - **REFACTOR**: prefer named arguments on DO/KV apis. ([c6e07055](https://github.com/invertase/dart_edge/commit/c6e0705553b1607637fcdd21ee7b316a29dbd2ca))
 - **REFACTOR**: update cli implementation ([#18](https://github.com/invertase/dart_edge/issues/18)). ([86802207](https://github.com/invertase/dart_edge/commit/868022075012814679e68a3a3e48003068db6bb6))


## 2023-02-13

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge` - `v0.0.4`](#edge---v004)
 - [`netlify_edge` - `v0.0.1-dev.5`](#netlify_edge---v001-dev5)
 - [`cloudflare_workers` - `v0.0.2+4`](#cloudflare_workers---v0024)
 - [`vercel_edge` - `v0.0.2+4`](#vercel_edge---v0024)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.5`
 - `cloudflare_workers` - `v0.0.2+4`
 - `vercel_edge` - `v0.0.2+4`

---

#### `edge` - `v0.0.4`

 - **FEAT**: add use-filesystem flag for prod vercel builds. ([ea9a6d12](https://github.com/invertase/dart_edge/commit/ea9a6d1216ded86439585b34a919bb3ccec6c025))


## 2023-02-10

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cloudflare_workers` - `v0.0.2+3`](#cloudflare_workers---v0023)
 - [`edge_runtime` - `v0.0.1+3`](#edge_runtime---v0013)
 - [`netlify_edge` - `v0.0.1-dev.4`](#netlify_edge---v001-dev4)
 - [`vercel_edge` - `v0.0.2+3`](#vercel_edge---v0023)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.4`
 - `vercel_edge` - `v0.0.2+3`

---

#### `cloudflare_workers` - `v0.0.2+3`

 - **FIX**: correctly construct RequestInit object when calling `fetch`. ([c75720b1](https://github.com/invertase/dart_edge/commit/c75720b1f2af10021b869c561d5b17f82049aba0))

#### `edge_runtime` - `v0.0.1+3`

 - **FIX**: correctly construct RequestInit object when calling `fetch`. ([c75720b1](https://github.com/invertase/dart_edge/commit/c75720b1f2af10021b869c561d5b17f82049aba0))


## 2023-02-08

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cloudflare_workers` - `v0.0.2+2`](#cloudflare_workers---v0022)
 - [`edge_runtime` - `v0.0.1+2`](#edge_runtime---v0012)
 - [`netlify_edge` - `v0.0.1-dev.3`](#netlify_edge---v001-dev3)
 - [`vercel_edge` - `v0.0.2+2`](#vercel_edge---v0022)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.3`
 - `vercel_edge` - `v0.0.2+2`

---

#### `cloudflare_workers` - `v0.0.2+2`

 - **FIX**: KV now returns nullable values. ([f1dba996](https://github.com/invertase/dart_edge/commit/f1dba9960570e1f2d4cc57b5ccf82257eaee12ac))

#### `edge_runtime` - `v0.0.1+2`

 - **FIX**: update request typo. ([18f13184](https://github.com/invertase/dart_edge/commit/18f13184999aae3c32a47c2ea9cbee3673aa9dec))


## 2023-02-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cloudflare_workers` - `v0.0.2+1`](#cloudflare_workers---v0021)
 - [`edge` - `v0.0.3`](#edge---v003)
 - [`edge_example` - `v0.0.2+1`](#edge_example---v0021)
 - [`edge_runtime` - `v0.0.1+1`](#edge_runtime---v0011)
 - [`netlify_edge` - `v0.0.1-dev.2`](#netlify_edge---v001-dev2)
 - [`vercel_edge` - `v0.0.2+1`](#vercel_edge---v0021)

---

#### `cloudflare_workers` - `v0.0.2+1`

 - **REFACTOR**: move edge runtime to separate package. ([95d4fab7](https://github.com/invertase/dart_edge/commit/95d4fab74cc7c3902bd737659dfee06d7feab353))
 - **DOCS**: update workers example readme. ([74010e40](https://github.com/invertase/dart_edge/commit/74010e401fd6598d1d6d2e3559664afd6fcf9261))
 - **DOCS**: add service bindings table of contents. ([7da0b111](https://github.com/invertase/dart_edge/commit/7da0b111e61915cf278f170ec5f150dc2df250b1))

#### `edge` - `v0.0.3`

 - **REFACTOR**: move edge runtime to separate package. ([95d4fab7](https://github.com/invertase/dart_edge/commit/95d4fab74cc7c3902bd737659dfee06d7feab353))
 - **FIX**: Uint8List as valid body type. ([a4be0591](https://github.com/invertase/dart_edge/commit/a4be0591679af3d4ce22c9aa05e663b1732ca4d7))
 - **FEAT**: add `dev` command & example. ([8936f513](https://github.com/invertase/dart_edge/commit/8936f5131c0d6621264138e89370cd6ee6fdc828))

#### `edge_example` - `v0.0.2+1`

 - **REFACTOR**: move edge runtime to separate package. ([95d4fab7](https://github.com/invertase/dart_edge/commit/95d4fab74cc7c3902bd737659dfee06d7feab353))

#### `edge_runtime` - `v0.0.1+1`

 - **REFACTOR**: move edge runtime to separate package. ([95d4fab7](https://github.com/invertase/dart_edge/commit/95d4fab74cc7c3902bd737659dfee06d7feab353))

#### `netlify_edge` - `v0.0.1-dev.2`

 - **REFACTOR**: move edge runtime to separate package. ([95d4fab7](https://github.com/invertase/dart_edge/commit/95d4fab74cc7c3902bd737659dfee06d7feab353))
 - **REFACTOR**: restructure runtime location. ([3b4407e4](https://github.com/invertase/dart_edge/commit/3b4407e400b73a6583fb96d724871d068f4e944e))
 - **FEAT**: rework edge new flow. ([0e337d73](https://github.com/invertase/dart_edge/commit/0e337d73cfd14c8e017ff6941eb0325ae29aca79))
 - **FEAT**: rework how DOs are handled. ([0b06f1ee](https://github.com/invertase/dart_edge/commit/0b06f1ee7cac1cf9a0c67355444f16b5e9633417))

#### `vercel_edge` - `v0.0.2+1`

 - **REFACTOR**: move edge runtime to separate package. ([95d4fab7](https://github.com/invertase/dart_edge/commit/95d4fab74cc7c3902bd737659dfee06d7feab353))
 - **DOCS**: add service bindings table of contents. ([7da0b111](https://github.com/invertase/dart_edge/commit/7da0b111e61915cf278f170ec5f150dc2df250b1))


## 2023-02-03

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`vercel_edge` - `v0.0.2`](#vercel_edge---v002)

---

#### `vercel_edge` - `v0.0.2`

 - **REFACTOR**: restructure runtime location. ([3b4407e4](https://github.com/invertase/dart_edge/commit/3b4407e400b73a6583fb96d724871d068f4e944e))
 - **FEAT**: improve CLI flow for build commands. ([179c1c65](https://github.com/invertase/dart_edge/commit/179c1c6595d6348f0204c043f5c41fce410c5e39))
 - **FEAT**: rework edge new flow. ([0e337d73](https://github.com/invertase/dart_edge/commit/0e337d73cfd14c8e017ff6941eb0325ae29aca79))
 - **FEAT**: rework how DOs are handled. ([0b06f1ee](https://github.com/invertase/dart_edge/commit/0b06f1ee7cac1cf9a0c67355444f16b5e9633417))


## 2023-02-03

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`cloudflare_workers` - `v0.0.2`](#cloudflare_workers---v002)

---

#### `cloudflare_workers` - `v0.0.2`

 - **REFACTOR**: restructure runtime location. ([3b4407e4](https://github.com/invertase/dart_edge/commit/3b4407e400b73a6583fb96d724871d068f4e944e))
 - **FEAT**: improve CLI flow for build commands. ([179c1c65](https://github.com/invertase/dart_edge/commit/179c1c6595d6348f0204c043f5c41fce410c5e39))
 - **FEAT**: rework edge new flow. ([0e337d73](https://github.com/invertase/dart_edge/commit/0e337d73cfd14c8e017ff6941eb0325ae29aca79))
 - **FEAT**: rework how DOs are handled. ([0b06f1ee](https://github.com/invertase/dart_edge/commit/0b06f1ee7cac1cf9a0c67355444f16b5e9633417))
 - **FEAT**: migrate init to named args. ([eaddc0ed](https://github.com/invertase/dart_edge/commit/eaddc0edfad67aef9abefb3dce9c1c69f0b19bdf))
 - **FEAT**: cf package. ([90bf775f](https://github.com/invertase/dart_edge/commit/90bf775f2b084aae0a0559773a4dc080c5eee9e7))
 - **FEAT**: extract into files. ([c7da53e6](https://github.com/invertase/dart_edge/commit/c7da53e67407dc66d4bff5bf529e333c7fc0e31a))


## 2023-02-03

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge` - `v0.0.2`](#edge---v002)
 - [`netlify_edge` - `v0.0.1-dev.2`](#netlify_edge---v001-dev2)
 - [`cloudflare_workers` - `v0.0.1-dev.2`](#cloudflare_workers---v001-dev2)
 - [`vercel_edge` - `v0.0.1-dev.2`](#vercel_edge---v001-dev2)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.2`
 - `cloudflare_workers` - `v0.0.1-dev.2`
 - `vercel_edge` - `v0.0.1-dev.2`

---

#### `edge` - `v0.0.2`

 - **REFACTOR**: restructure runtime location. ([3b4407e4](https://github.com/invertase/dart_edge/commit/3b4407e400b73a6583fb96d724871d068f4e944e))
 - **FEAT**: improve CLI flow for build commands. ([179c1c65](https://github.com/invertase/dart_edge/commit/179c1c6595d6348f0204c043f5c41fce410c5e39))
 - **FEAT**: rework edge new flow. ([0e337d73](https://github.com/invertase/dart_edge/commit/0e337d73cfd14c8e017ff6941eb0325ae29aca79))
 - **FEAT**: rework how DOs are handled. ([0b06f1ee](https://github.com/invertase/dart_edge/commit/0b06f1ee7cac1cf9a0c67355444f16b5e9633417))
 - **FEAT**: migrate init to named args. ([eaddc0ed](https://github.com/invertase/dart_edge/commit/eaddc0edfad67aef9abefb3dce9c1c69f0b19bdf))


## 2023-02-03

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge` - `v0.0.2`](#edge---v002)
 - [`netlify_edge` - `v0.0.1-dev.2`](#netlify_edge---v001-dev2)
 - [`vercel_edge` - `v0.0.1-dev.2`](#vercel_edge---v001-dev2)
 - [`cloudflare_workers` - `v0.0.1-dev.2`](#cloudflare_workers---v001-dev2)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.2`
 - `vercel_edge` - `v0.0.1-dev.2`
 - `cloudflare_workers` - `v0.0.1-dev.2`

---

#### `edge` - `v0.0.2`

 - **REFACTOR**: restructure runtime location. ([3b4407e4](https://github.com/invertase/dart_edge/commit/3b4407e400b73a6583fb96d724871d068f4e944e))
 - **FEAT**: improve CLI flow for build commands. ([179c1c65](https://github.com/invertase/dart_edge/commit/179c1c6595d6348f0204c043f5c41fce410c5e39))
 - **FEAT**: rework edge new flow. ([0e337d73](https://github.com/invertase/dart_edge/commit/0e337d73cfd14c8e017ff6941eb0325ae29aca79))
 - **FEAT**: rework how DOs are handled. ([0b06f1ee](https://github.com/invertase/dart_edge/commit/0b06f1ee7cac1cf9a0c67355444f16b5e9633417))
 - **FEAT**: migrate init to named args. ([eaddc0ed](https://github.com/invertase/dart_edge/commit/eaddc0edfad67aef9abefb3dce9c1c69f0b19bdf))


## 2023-02-03

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`edge` - `v0.0.2`](#edge---v002)
 - [`netlify_edge` - `v0.0.1-dev.2`](#netlify_edge---v001-dev2)
 - [`cloudflare_workers` - `v0.0.1-dev.2`](#cloudflare_workers---v001-dev2)
 - [`vercel_edge` - `v0.0.1-dev.2`](#vercel_edge---v001-dev2)

Packages with dependency updates only:

> Packages listed below depend on other packages in this workspace that have had changes. Their versions have been incremented to bump the minimum dependency versions of the packages they depend upon in this project.

 - `netlify_edge` - `v0.0.1-dev.2`
 - `cloudflare_workers` - `v0.0.1-dev.2`
 - `vercel_edge` - `v0.0.1-dev.2`

---

#### `edge` - `v0.0.2`

 - **REFACTOR**: restructure runtime location. ([3b4407e4](https://github.com/invertase/dart_edge/commit/3b4407e400b73a6583fb96d724871d068f4e944e))
 - **FEAT**: improve CLI flow for build commands. ([179c1c65](https://github.com/invertase/dart_edge/commit/179c1c6595d6348f0204c043f5c41fce410c5e39))
 - **FEAT**: rework edge new flow. ([0e337d73](https://github.com/invertase/dart_edge/commit/0e337d73cfd14c8e017ff6941eb0325ae29aca79))
 - **FEAT**: rework how DOs are handled. ([0b06f1ee](https://github.com/invertase/dart_edge/commit/0b06f1ee7cac1cf9a0c67355444f16b5e9633417))
 - **FEAT**: migrate init to named args. ([eaddc0ed](https://github.com/invertase/dart_edge/commit/eaddc0edfad67aef9abefb3dce9c1c69f0b19bdf))

