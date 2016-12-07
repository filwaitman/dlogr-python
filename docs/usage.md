Dlogr Python Client documentation
=================================

|Table of contents                                                                                                     |
|----------------------------------------------------------------------------------------------------------------------|
|[Intro] [Using the mixin to send data to API](#intro-using-the-mixin-to-send-data-to-api)                             |   
|[Intro] [Using the client from scratch](#intro-using-the-client-from-scratch)                                         | 
|----------------------------------------------------------------------------------------------------------------------|
|[Client] [Auth] [Login](#client-auth-login)                                                                           |
|[Client] [Auth] [Verify account](#client-auth-verify-account)                                                         |
|[Client] [Auth] [Reset password](#client-auth-reset-password)                                                         |
|[Client] [Auth] [Change password](#client-auth-change-password)                                                       |
|[Client] [Customer] [List](#client-customer-list)                                                                     |
|[Client] [Customer] [Create](#client-customer-create)                                                                 |
|[Client] [Customer] [Retrieve](#client-customer-retrieve)                                                             |
|[Client] [Customer] [Update](#client-customer-update)                                                                 |
|[Client] [Customer] [Delete](#client-customer-delate)                                                                 |
|[Client] [Event] [List](#client-event-list)                                                                           |
|[Client] [Event] [Create](#client-event-create)                                                                       |
|[Client] [Event] [Retrieve](#client-event-retrieve)                                                                   |
|[Client] [Event] [Update](#client-event-update)                                                                       |
|[Client] [Event] [Delete](#client-event-delate)                                                                       |



## Intro


### [Intro] Using the mixin to send data to API

If you're here to learn how to use this client on your project, this section is for you. This client has created a super-simple way to integrate to the API. Just follow the instructions below:

* Set the Dlogr environment vars:
  * `DLOGR_URL`: `[required]` the URL from Dlogr API. You should probably use `https://api.dlogr.com` here.
  * `DLOGR_ACCESS_KEY`: `[required]` the API Auth Token you received then registered on Dlogr. You can get it again by logging in via either [web client](https://www.dlogr.com/auth/signin/) or [Python client](#)
  * `DLOGR_ASYNC`: `[optional]` Responsible for sending events to API asynchronously. Defaults to `True` if [celery](http://www.celeryproject.org/) is installed and `False` otherwise. Of course, when `DLOGR_ASYNC` is `True` it requires [celery](http://www.celeryproject.org/) installed and configured.

* Inherit `DlogrModelMixin` on the classes you want to connect with Dlogr
  * For instance, replace this:
        ```
        class User(Model):
            id = UUIDField()
            name = Charfield
            # ...
        ```
        To this:
        ```
        from dlogr.mixins import DlogrModelMixin  # Added

        class User(DlogrModelMixin, Model):  # Changed
            id = UUIDField()
            name = Charfield
            # ...
        ```

* Use the inherited method to send the data
    ```
    user = User()
    user.dlogr_send('User made a login')  # There's a timestamp parameter here. Defaults to now.
    ```

And that's it! You can customize a few class attributes on this mixin:
* `DLOGR_IDENTIFIER_FIELD`: `[optional, defaults to 'id']` the unique identifier attribute for a given object.
* `DLOGR_HUMAN_IDENTIFIER_FIELD`: `[optional, defaults to None]` The human-readable identifier attribute for a given object. When it's `None` Dlogr will get this info by calling `'{}'.format(obj)`.

In order to customize those attributes just set them on your model like:
    ```
    from dlogr.mixins import DlogrModelMixin

    class User(DlogrModelMixin, Model):
        DLOGR_IDENTIFIER_FIELD = 'uuid'
        DLOGR_HUMAN_IDENTIFIER_FIELD = 'name'

        uuid = UUIDField()
        name = Charfield
        # ...
    ```


### [Intro] Using the client from scratch

You can of course use the client to reach every single endpoint from Dlogr API. Take a look below how to instantiate it.
    ```
    from dlogr.clients import DlogrClient

    client = DlogrClient(base_api_url='https://api.dlogr.com')  # This is the only required parameter

    # You can use the client authenticated by passing the API Auth Token.
    client = DlogrClient(base_api_url='https://api.dlogr.com', auth_token='SUPERTOKENHERE')

    # You can also use the client authenticated by passing the API credentials.
    client = DlogrClient(base_api_url='https://api.dlogr.com', auth_credentials=('filwaitman@gmail.com', 'sikret'))
    ```

Dlogr Python client acts as a request wrapper. So on every API endpoint call, the `Response()` object will be returned.  
Dlogr Python client also wraps the request exceptions on its own exception: `DlogrAPIError`.



## Client


### [Client] [Auth] Login
* Signature: `client.Auth.login(email, password)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#auth-login endpoint.


### [Client] [Auth] Verify account
* Signature: `client.Auth.verify_account(token)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#auth-verify-account endpoint.


### [Client] [Auth] Reset password
* Signature: `client.Auth.reset_password(email)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#auth-reset-password endpoint.


### [Client] [Auth] Change password
* Signature: `client.Auth.change_password(new_password, email=None, password=None, reset_token=None)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#auth-change-password endpoint.


### [Client] [Customer] List
* Signature: `client.Customer.list(**params)` (params are query params. You can use params such as `limit`and `offset` for pagination, for instance)
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#customer-list endpoint.


### [Client] [Customer] Create
* Signature: `client.Customer.retrieve(**data)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#customer-create endpoint.


### [Client] [Customer] Retrieve
* Signature: `client.Customer.retrieve(identifier)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#customer-retrieve endpoint.


### [Client] [Customer] Update
* Signature: `client.Customer.update(identifier, **data)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#customer-update endpoint.


### [Client] [Customer] Delete
* Signature: `client.Customer.delete(identifier)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#customer-delete endpoint.


### [Client] [Event] List
* Signature: `client.Event.list(**params)` (params are query params. You can use params such as `limit`and `offset` for pagination, for instance)
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#event-list endpoint.


### [Client] [Event] Create
* Signature: `client.Event.retrieve(**data)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#event-create endpoint.


### [Client] [Event] Retrieve
* Signature: `client.Event.retrieve(identifier)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#event-retrieve endpoint.


### [Client] [Event] Update
* Signature: `client.Event.update(identifier, **data)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#event-update endpoint.


### [Client] [Event] Delete
* Signature: `client.Event.delete(identifier)`
* Calls the https://github.com/filwaitman/dlogr-api/blob/master/docs/api.md#event-delete endpoint.
