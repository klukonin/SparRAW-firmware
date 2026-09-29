/* wbe_driver__pcie_debug @ 0x8ef90c, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wbe_driver.cpp
 *   PCIE DEBUG %d (ring#=%d): 0x%08X
 *   PCIE.PXE.PUP.DBG.PCIE_PCIE_PXE_PUP_DBG_0 = 0x%08X
 *   PCIE.PXE.PDN.CACHE_REQ_FIFO_CONTROLLER.PCIE_PXE_PDN_CACHE_REQ_FIFO = 0x%08X
 *   PCIE.PXE.PDN.TX_DP_FIFO_CONTROLLER = 0x%08X
 *   PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE.SW_PORT1_DEBUG_TX_PCPL_REMOTE_0 = 0x%08X
 *   PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE.SW_PORT1_DEBUG_TX_PCPL_REMOTE_1 = 0x%08X
 *   PCIE.SW_PORT1.DEBUG.TX.PCPL.REMOTE.SW_PORT1_DEBUG_TX_PCPL_REMOTE_2 = 0x%08X
 * Зовут его: wbe_driver__pcie_debug_isr
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.wbe_driver__pcie_debug,"ax",@progbits
	.global wbe_driver__pcie_debug
wbe_driver__pcie_debug:
	.global L_8ef90c
L_8ef90c:
	push_s blink
L_8ef90e:
	bl L_8c02b8
L_8ef912:
	mov_s r14,0x882e80
L_8ef918:
	ld_s r0,[r14,0x5c]
L_8ef91a:
	extb r16,r0
L_8ef91e:
	mov r17,0x0
L_8ef922:
	b_s L_8ef930
	.global L_8ef924
L_8ef924:
	asr r0,r16
L_8ef928:
	extb r16,r0
L_8ef92c:
	add r17,r17,0x1
	.global L_8ef930
L_8ef930:
	brhs r17,0x8,L_8ef9bc
L_8ef934:
	bbit0 r16,0x0,L_8ef924
L_8ef938:
	bic.f r13,r17,0x7
L_8ef93c:
	bne_s L_8ef956
	.global L_8ef93e
L_8ef93e:
	ld_s r0,[r14,0x58]
L_8ef940:
	asl r1,r17,0x4
L_8ef944:
	bic r0,r0,0x70
L_8ef948:
	or_s r0,r0,r1
L_8ef94a:
	st_s r0,[r14,0x58]
L_8ef94c:
	ld_s r0,[r14,0x58]
L_8ef94e:
	brne r17,0x0,L_8ef96a
L_8ef952:
	bclr_s r0,r0,0x8
L_8ef954:
	b_s L_8ef96c
	.global L_8ef956
L_8ef956:
	mov_s r0,blink
L_8ef958:
	mov_s r2,0x10032e4
L_8ef95e:
	mov_s r1,0xac
L_8ef960:
	bl.d L_8c82c0
L_8ef964:
	mov r3,0x40d
L_8ef968:
	b_s L_8ef93e
	.global L_8ef96a
L_8ef96a:
	bset_s r0,r0,0x8
	.global L_8ef96c
L_8ef96c:
	st_s r0,[r14,0x58]
L_8ef96e:
	brne_s r13,0,L_8ef9a8
	.global L_8ef970
L_8ef970:
	ld_s r0,[r14,0x58]
L_8ef972:
	mov_s r13,0x0
L_8ef974:
	bic r0,r0,0x7
L_8ef978:
	or r0,r0,r17
L_8ef97c:
	st_s r0,[r14,0x58]
L_8ef97e:
	mov_s r15,0x10
	.global L_8ef980
L_8ef980:
	mov_s r2,0x100357c
L_8ef986:
	mov_s r0,0x882ed8
L_8ef98c:
	ld.as r5,[r0,r13]
L_8ef990:
	mov_s r0,0xf
L_8ef992:
	mov_s r1,0x2
L_8ef994:
	mov_s r3,r13
L_8ef996:
	bl.d L_8ee034
L_8ef99a:
	mov r4,r17
L_8ef99e:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_8ef9a0:
	/* brhs.d r15,0x1,0x008ef980 */
	.byte 0xe1,0x0f,0x75,0x90
L_8ef9a4:
	/* _add_s r13,0x1 */
	.byte 0x01,0xe5
L_8ef9a6:
	b_s L_8ef924
	.global L_8ef9a8
L_8ef9a8:
	mov_s r0,blink
L_8ef9aa:
	mov_s r2,0x10032e4
L_8ef9b0:
	mov_s r1,0xac
L_8ef9b2:
	bl.d L_8c82c0
L_8ef9b6:
	mov r3,0x414
L_8ef9ba:
	b_s L_8ef970
	.global L_8ef9bc
L_8ef9bc:
	ld_s r3,[r14,0xc]
L_8ef9be:
	mov_s r2,0x10035a0
L_8ef9c4:
	mov_s r0,0xf
L_8ef9c6:
	bl.d L_8edfcc
L_8ef9ca:
	mov_s r1,0x2
L_8ef9cc:
	ld_s r3,[r14,0x4]
L_8ef9ce:
	mov_s r2,0x10035d4
L_8ef9d4:
	mov_s r0,0xf
L_8ef9d6:
	bl.d L_8edfcc
L_8ef9da:
	mov_s r1,0x2
L_8ef9dc:
	ld_s r3,[r14,0x8]
L_8ef9de:
	mov_s r2,0x1003620
L_8ef9e4:
	mov_s r0,0xf
L_8ef9e6:
	bl.d L_8edfcc
L_8ef9ea:
	mov_s r1,0x2
L_8ef9ec:
	mov_s r13,0x882300
L_8ef9f2:
	ld_s r3,[r13,0x34]
L_8ef9f4:
	mov_s r2,0x100364c
L_8ef9fa:
	mov_s r0,0xf
L_8ef9fc:
	bl.d L_8edfcc
L_8efa00:
	mov_s r1,0x2
L_8efa02:
	ld_s r3,[r13,0x38]
L_8efa04:
	mov_s r2,0x1003698
L_8efa0a:
	mov_s r0,0xf
L_8efa0c:
	bl.d L_8edfcc
L_8efa10:
	mov_s r1,0x2
L_8efa12:
	ld_s r3,[r13,0x3c]
L_8efa14:
	mov_s r2,0x10036e4
L_8efa1a:
	mov_s r0,0xf
L_8efa1c:
	bl.d L_8edfcc
L_8efa20:
	mov_s r1,0x2
L_8efa22:
	ld_s r3,[r13,0x40]
L_8efa24:
	mov_s r2,0x1003730
L_8efa2a:
	mov_s r0,0xf
L_8efa2c:
	bl.d L_8edfcc
L_8efa30:
	mov_s r1,0x2
L_8efa32:
	mov_s r13,0x882280
L_8efa38:
	ld_s r3,[r13,0x50]
L_8efa3a:
	mov_s r2,0x100377c
L_8efa40:
	mov_s r0,0xf
L_8efa42:
	bl.d L_8edfcc
L_8efa46:
	mov_s r1,0x2
L_8efa48:
	ld_s r3,[r13,0x54]
L_8efa4a:
	mov_s r2,0x10037c8
L_8efa50:
	mov_s r0,0xf
L_8efa52:
	bl.d L_8edfcc
L_8efa56:
	mov_s r1,0x2
L_8efa58:
	ld_s r3,[r13,0x58]
L_8efa5a:
	mov_s r2,0x1003814
L_8efa60:
	mov_s r0,0xf
L_8efa62:
	bl.d L_8edfcc
L_8efa66:
	mov_s r1,0x2
L_8efa68:
	ld_s r3,[r13,0x5c]
L_8efa6a:
	mov_s r2,0x1003860
L_8efa70:
	mov_s r0,0xf
L_8efa72:
	bl.d L_8edfcc
L_8efa76:
	mov_s r1,0x2
L_8efa78:
	b L_8c031c
