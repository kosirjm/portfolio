function [serverQueue] = queue(packet, queueSize, serverQueue)
%QUEUE Summary of this function goes here
%   Detailed explanation goes here

if length(serverQueue) > queueSize
% Block
else
packet = 
serverQueue(length(serverQueue) + 1) = packet
end
