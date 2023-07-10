# This file was generated by the Julia OpenAPI Code Generator
# Do not modify this file directly. Modify the OpenAPI specification instead.


@doc raw"""service_usage
Metrics about the resource usage of the secondary web service.  Back-ends are not expected to update the metrics in real-time. For detailed usage metrics for individual processing steps, metrics can be added to the logs (e.g. &#x60;GET /jobs/{job_id}/logs&#x60;) with the same schema.

    ServiceUsage(;
        cpu=nothing,
        memory=nothing,
        duration=nothing,
        network=nothing,
        disk=nothing,
        storage=nothing,
    )

    - cpu::UsageCpu
    - memory::UsageMemory
    - duration::UsageDuration
    - network::UsageNetwork
    - disk::UsageDisk
    - storage::UsageStorage
"""
Base.@kwdef mutable struct ServiceUsage <: OpenAPI.APIModel
    cpu = nothing # spec type: Union{ Nothing, UsageCpu }
    memory = nothing # spec type: Union{ Nothing, UsageMemory }
    duration = nothing # spec type: Union{ Nothing, UsageDuration }
    network = nothing # spec type: Union{ Nothing, UsageNetwork }
    disk = nothing # spec type: Union{ Nothing, UsageDisk }
    storage = nothing # spec type: Union{ Nothing, UsageStorage }

    function ServiceUsage(cpu, memory, duration, network, disk, storage, )
        OpenAPI.validate_property(ServiceUsage, Symbol("cpu"), cpu)
        OpenAPI.validate_property(ServiceUsage, Symbol("memory"), memory)
        OpenAPI.validate_property(ServiceUsage, Symbol("duration"), duration)
        OpenAPI.validate_property(ServiceUsage, Symbol("network"), network)
        OpenAPI.validate_property(ServiceUsage, Symbol("disk"), disk)
        OpenAPI.validate_property(ServiceUsage, Symbol("storage"), storage)
        return new(cpu, memory, duration, network, disk, storage, )
    end
end # type ServiceUsage

const _property_types_ServiceUsage = Dict{Symbol,String}(Symbol("cpu")=>"UsageCpu", Symbol("memory")=>"UsageMemory", Symbol("duration")=>"UsageDuration", Symbol("network")=>"UsageNetwork", Symbol("disk")=>"UsageDisk", Symbol("storage")=>"UsageStorage", )
OpenAPI.property_type(::Type{ ServiceUsage }, name::Symbol) = Union{Nothing,eval(Base.Meta.parse(_property_types_ServiceUsage[name]))}

function check_required(o::ServiceUsage)
    true
end

function OpenAPI.validate_property(::Type{ ServiceUsage }, name::Symbol, val)
end