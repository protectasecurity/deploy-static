# Static GitHub Actions

Static GitHub Actions allows you to deploy static content

## Example usage

```yaml
on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: develop
    steps:
      - uses: actions/download-artifact@v3
        with:
          name: dist
      - uses: protectasecurity/deploy-static@v1
        with:
          workspace: 'dist'
          bucket: ${{ secrets.S3_BUCKET }}
          distribution: ${{ secrets.CLOUDFRONT_DISTRIBUTION }}
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'us-east-1'
```

## Inputs

- `workspace` **Required** Relative path to place the content
- `bucket` **Required** S3 Bucket
- `distribution` **Required** Cloudfront Distribution

## Outputs

- `status` Returned status code.

## Environment

- `AWS_ACCESS_KEY_ID` **Required**
- `AWS_SECRET_ACCESS_KEY` **Required**
- `AWS_DEFAULT_REGION` **Required**

## Authors

- [Ronnie Ayala](https://github.com/ronnieacs)