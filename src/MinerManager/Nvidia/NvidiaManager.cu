// Copyright (c) 2019, Zpalmtree
//
// Please see the included LICENSE file for more information.

#include <iostream>
#include <map>
#include <vector>

#include "Nvidia/Argon2.h"
#include "Utilities/ColouredMsg.h"

std::vector<std::tuple<std::string, bool, int>> getNvidiaDevicesActual()
{
    std::vector<std::tuple<std::string, bool, int>> devices;

    int numberDevices;
    cudaGetDeviceCount(&numberDevices);

    for (int i = 0; i < numberDevices; i++)
    {
        cudaDeviceProp prop;
        cudaGetDeviceProperties(&prop, i);

        devices.push_back({prop.name, true, i});
    }

    return devices;
}

void printNvidiaHeader()
{
    std::cout << InformationMsg<std::string>("* ") << WhiteMsg<std::string>("NVIDIA DEVICES", 25);

    int numberDevices;
    cudaGetDeviceCount(&numberDevices);

    if (numberDevices == 0)
    {
        std::cout << WarningMsg<std::string>("None found") << std::endl;
        return;
    }

    std::map<std::string, std::vector<cudaDeviceProp>> gpus;

    for (int i = 0; i < numberDevices; i++)
    {
        cudaDeviceProp prop;
        cudaGetDeviceProperties(&prop, i);

        std::string deviceName = prop.name;

        gpus[deviceName].push_back(prop);
    }

    int i = 0;

    for (const auto gpu : gpus)
    {
        const auto name = gpu.first;
        const auto properties = gpu.second;

        if (i != 0)
        {
            std::cout << ", ";
        }

        size_t numDevices = properties.size();

        std::cout << SuccessMsg<size_t>(numDevices) << SuccessMsg<std::string>("x ") << SuccessMsg<std::string>(name);

        i++;
    }

    std::cout << std::endl;
}

void resumeNvidiaMining()
{
    int numberDevices;
    cudaGetDeviceCount(&numberDevices);

    if (numberDevices == 0)
    {
        return;
    }

    hash();
}
