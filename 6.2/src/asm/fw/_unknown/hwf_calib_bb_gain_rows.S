/* hwf_calib_bb_gain_rows @ 0x8d4eb4, 1052 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *         Reference row wasn't found. cntr = %d, indexs = %x, dc = %x
 *         Gain measure is out of BOUND VGA_INDEX_%d, vga_idx_vec = %x, sat/quant = %x
 * Зовут его: Calib__Measure_VGA_Gains
 * Зовёт сам: __ld_r25_to_r13_ret, __st_r25_to_r13, calib_bb_gain__pack_row, calib_row_step, calib_vga_coarse, fw_log_emit3, hwd_abif__set_agc_column, hwf_calib_bb_gain__args, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_calib_bb_gain_rows
hwf_calib_bb_gain_rows:
	.global L_8d4eb4
L_8d4eb4:
	sub_s sp,sp,0x20
L_8d4eb6:
	push_s blink
L_8d4eb8:
	bl L_8c01b8
L_8d4ebc:
	sub sp,sp,0x98
L_8d4ec0:
	mov_s r17,r0
L_8d4ec2:
	st r0,[sp, 0xd0]
L_8d4ec6:
	st_s r1,[sp,0x40]
L_8d4ec8:
	mov_s r19,r2
L_8d4eca:
	mov_s r20,r3
L_8d4ecc:
	st r4,[sp, 0x44]
L_8d4ed0:
	st r5,[sp, 0x48]
L_8d4ed4:
	st r5,[sp, 0xe4]
L_8d4ed8:
	st r6,[sp, 0x4c]
L_8d4edc:
	st r6,[sp, 0xe8]
L_8d4ee0:
	st r7,[sp, 0x3c]
L_8d4ee4:
	st r7,[sp, 0xec]
L_8d4ee8:
	mov_s r13,0x1
L_8d4eea:
	mov_s r0,0x803814
L_8d4ef0:
	ld_s r0,[r0,0x4]
L_8d4ef2:
	st_s r13,[sp,0x58]
L_8d4ef4:
	st_s r0,[sp,0x5c]
L_8d4ef6:
	mov r21,0x0
L_8d4efa:
	stb r21,[sp, 0x6c]
L_8d4efe:
	add_s r14,sp,0x5c
L_8d4f00:
	mov_s r0,sp
L_8d4f02:
	add3 r1,sp,0x1d
L_8d4f06:
	bl.d L_8c0380
L_8d4f0a:
	mov_s r2,0xc
L_8d4f0c:
	st_s r13,[sp,0xc]
L_8d4f0e:
	st r21,[sp, 0x10]
L_8d4f12:
	add3 r23,sp,0xe
L_8d4f16:
	st r23,[sp, 0x14]
L_8d4f1a:
	add3 r0,sp,0x10
L_8d4f1e:
	st_s r0,[sp,0x50]
L_8d4f20:
	st_s r0,[sp,0x18]
L_8d4f22:
	ld_s r3,[sp,0x40]
L_8d4f24:
	mov_s r0,r13
L_8d4f26:
	ld r6,[sp, 0x44]
L_8d4f2a:
	mov_s r1,r14
L_8d4f2c:
	mov_s r2,r17
L_8d4f2e:
	mov r4,r19
L_8d4f32:
	mov r5,r20
L_8d4f36:
	bl.d L_8d4e08
L_8d4f3a:
	ld r7,[sp, 0x48]
L_8d4f3e:
	ld_s r0,[sp,0x58]
L_8d4f40:
	b_s L_8d4f46
	.global L_8d4f42
L_8d4f42:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d4f44:
	extb_s r13,r13
	.global L_8d4f46
L_8d4f46:
	cmp_s r13,0x4
L_8d4f48:
	bhi L_8d52c4
L_8d4f4c:
	cmp_s r0,0x1
L_8d4f4e:
	bne L_8d52c4
L_8d4f52:
	mov r18,0x1
L_8d4f56:
	stb r18,[sp, 0x7c]
L_8d4f5a:
	stb r18,[sp, 0x7d]
L_8d4f5e:
	ld_s r0,[sp,0x5c]
L_8d4f60:
	st r21,[sp, 0x78]
L_8d4f64:
	st_s r0,[sp,0x64]
L_8d4f66:
	add2 r24,sp,0x19
L_8d4f6a:
	st_s r0,[sp,0x68]
L_8d4f6c:
	add3 r25,sp,0xd
L_8d4f70:
	mov_s r0,r18
L_8d4f72:
	mov_s r1,0x0
L_8d4f74:
	bl.d L_8cf080
L_8d4f78:
	ld_s r2,[sp,0x50]
L_8d4f7a:
	stb_s r13,[sp,0x6c]
L_8d4f7c:
	st r21,[sp, 0x90]
L_8d4f80:
	mov_s r0,0x4
L_8d4f82:
	stb r0,[sp, 0x94]
L_8d4f86:
	brne r13,0x4,L_8d4f90
L_8d4f8a:
	mov_s r0,0x3
L_8d4f8c:
	stb r0,[sp, 0x94]
	.global L_8d4f90
L_8d4f90:
	cmp_s r13,0x1
L_8d4f92:
	mov_s r15,0x0
L_8d4f94:
	bne_s L_8d50ea
L_8d4f96:
	mov_s r22,r15
L_8d4f98:
	b_s L_8d50ac
	.global L_8d4f9a
L_8d4f9a:
	mov_s r0,r14
L_8d4f9c:
	bl.d L_8e97bc
L_8d4fa0:
	mov_s r1,0x1
L_8d4fa2:
	mov_s r5,r0
L_8d4fa4:
	mov_s r0,r16
L_8d4fa6:
	bl.d L_8e97bc
L_8d4faa:
	mov_s r1,r18
L_8d4fac:
	mov_s r4,r0
L_8d4fae:
	mov_s r1,0x101ca5c
L_8d4fb4:
	mov_s r0,0x6
L_8d4fb6:
	mov_s r2,r15
L_8d4fb8:
	bl.d L_8dcd00
L_8d4fbc:
	mov_s r3,r5
L_8d4fbe:
	mov_s r0,0x2
L_8d4fc0:
	st_s r0,[sp,0x58]
L_8d4fc2:
	b_s L_8d50ac
	.global L_8d4fc4
L_8d4fc4:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d4fc6:
	ld_s r0,[sp,0x64]
L_8d4fc8:
	extb_s r15,r15
L_8d4fca:
	st_s r0,[sp,0x60]
L_8d4fcc:
	add_s r14,sp,0x60
L_8d4fce:
	mov_s r0,sp
L_8d4fd0:
	add3 r1,sp,0x1d
L_8d4fd4:
	bl.d L_8c0380
L_8d4fd8:
	mov_s r2,0xc
L_8d4fda:
	ldb_s r0,[sp,0x6c]
L_8d4fdc:
	st r21,[sp, 0xc]
L_8d4fe0:
	st_s r0,[sp,0x10]
L_8d4fe2:
	st r23,[sp, 0x14]
L_8d4fe6:
	add2 r16,sp,0x21
L_8d4fea:
	st r16,[sp, 0x18]
L_8d4fee:
	ld_s r3,[sp,0x40]
L_8d4ff0:
	mov_s r0,0x1
L_8d4ff2:
	ld r6,[sp, 0x44]
L_8d4ff6:
	mov_s r1,r14
L_8d4ff8:
	mov_s r2,r17
L_8d4ffa:
	mov r4,r19
L_8d4ffe:
	mov r5,r20
L_8d5002:
	bl.d L_8d4e08
L_8d5006:
	ld r7,[sp, 0x48]
L_8d500a:
	mov_s r0,sp
L_8d500c:
	add2 r1,sp,0x39
L_8d5010:
	bl.d L_8c0380
L_8d5014:
	mov_s r2,0x10
L_8d5016:
	ld_s r0,[sp,0x70]
L_8d5018:
	mov_s r2,r14
L_8d501a:
	ld_s r1,[sp,0x74]
L_8d501c:
	mov_s r3,r17
L_8d501e:
	ld r4,[sp, 0x40]
L_8d5022:
	mov r5,r19
L_8d5026:
	mov r6,r20
L_8d502a:
	bl.d L_8dcb6c
L_8d502e:
	ld r7,[sp, 0x44]
L_8d5032:
	ld r0,[sp, 0xf0]
L_8d5036:
	ld_s r1,[sp,0x70]
L_8d5038:
	st_s r0,[sp,0x0]
L_8d503a:
	ld_s r0,[sp,0x74]
L_8d503c:
	st_s r1,[sp,0x4]
L_8d503e:
	st_s r0,[sp,0x8]
L_8d5040:
	ld_s r0,[sp,0x7c]
L_8d5042:
	mov_s r2,r19
L_8d5044:
	ld_s r1,[sp,0x78]
L_8d5046:
	mov_s r3,r20
L_8d5048:
	st_s r1,[sp,0xc]
L_8d504a:
	st_s r0,[sp,0x10]
L_8d504c:
	st r25,[sp, 0x14]
L_8d5050:
	st_s r14,[sp,0x18]
L_8d5052:
	st r24,[sp, 0x1c]
L_8d5056:
	add3 r0,sp,0x11
L_8d505a:
	st_s r0,[sp,0x20]
L_8d505c:
	add3 r0,sp,0x12
L_8d5060:
	st_s r0,[sp,0x24]
L_8d5062:
	add2 r0,sp,0x25
L_8d5066:
	st_s r0,[sp,0x28]
L_8d5068:
	st_s r13,[sp,0x2c]
L_8d506a:
	add_s r0,sp,0x6c
L_8d506c:
	st_s r0,[sp,0x30]
L_8d506e:
	st r18,[sp, 0x34]
L_8d5072:
	add_s r0,sp,0x58
L_8d5074:
	st_s r0,[sp,0x38]
L_8d5076:
	ld_s r1,[sp,0x40]
L_8d5078:
	mov_s r0,r17
L_8d507a:
	ld r4,[sp, 0x44]
L_8d507e:
	ld r5,[sp, 0x48]
L_8d5082:
	ld r6,[sp, 0x4c]
L_8d5086:
	bl.d L_8d53b8
L_8d508a:
	ld r7,[sp, 0x3c]
L_8d508e:
	mov_s r22,r0
L_8d5090:
	ld_s r0,[sp,0x60]
L_8d5092:
	ld_s r1,[sp,0x70]
L_8d5094:
	st_s r0,[sp,0x68]
L_8d5096:
	ld r0,[sp, 0x84]
L_8d509a:
	st_s r1,[sp,0x78]
L_8d509c:
	st r0,[sp, 0x88]
L_8d50a0:
	ld_s r0,[sp,0x74]
L_8d50a2:
	cmp_s r15,0x14
L_8d50a4:
	st_s r0,[sp,0x7c]
L_8d50a6:
	mov r18,0x0
L_8d50aa:
	beq_s L_8d4f9a
	.global L_8d50ac
L_8d50ac:
	brne r22,0x0,L_8d50b6
L_8d50b0:
	ld_s r0,[sp,0x58]
L_8d50b2:
	breq r0,0x1,L_8d4fc4
	.global L_8d50b6
L_8d50b6:
	ld r18,[sp, 0x70]
L_8d50ba:
	ld r22,[sp, 0xf4]
L_8d50be:
	st r18,[r22]
L_8d50c2:
	ldb_s r0,[sp,0x60]
L_8d50c4:
	stb r0,[r22, 0x4]
L_8d50c8:
	ldb r0,[sp, 0x61]
L_8d50cc:
	stb r0,[r22, 0x5]
L_8d50d0:
	ldb r0,[sp, 0x62]
L_8d50d4:
	stb r0,[r22, 0x6]
L_8d50d8:
	ldb r0,[sp, 0x63]
L_8d50dc:
	stb r0,[r22, 0x7]
L_8d50e0:
	ld r0,[sp, 0x84]
L_8d50e4:
	st r0,[sp, 0x8c]
L_8d50e8:
	b_s L_8d5100
	.global L_8d50ea
L_8d50ea:
	ld r22,[sp, 0xf4]
L_8d50ee:
	ld r0,[r22, 0x4]
L_8d50f2:
	ld r18,[r22]
L_8d50f6:
	st_s r0,[sp,0x60]
L_8d50f8:
	ld r0,[sp, 0x8c]
L_8d50fc:
	st r0,[sp, 0x84]
	.global L_8d5100
L_8d5100:
	add r0,r22,0x3
L_8d5104:
	st_s r0,[sp,0x54]
L_8d5106:
	mov_s r15,0x1
L_8d5108:
	b_s L_8d5120
	.global L_8d510a
L_8d510a:
	ld r0,[sp, 0xf8]
L_8d510e:
	asl_s r1,r13,0x5
L_8d5110:
	add_s r0,r0,r1
L_8d5112:
	sub r0,r0,0x24
L_8d5116:
	add2_s r0,r0,r15
L_8d5118:
	st r21,[r0]
	.global L_8d511c
L_8d511c:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8d511e:
	extb_s r15,r15
	.global L_8d5120
L_8d5120:
	add r25,sp,r13
L_8d5124:
	ldb r1,[r25, 0xcf]
L_8d5128:
	cmp_s r15,r1
L_8d512a:
	bgt.d L_8d4f42
L_8d512e:
	ld_s r0,[sp,0x58]
L_8d5130:
	cmp_s r0,0x1
L_8d5132:
	bne_s L_8d4f42
L_8d5134:
	ld_s r0,[sp,0x54]
L_8d5136:
	ldb_s r0,[r0,r13]
L_8d5138:
	breq r15,r0,L_8d510a
L_8d513c:
	add3 r16,sp,0xc
L_8d5140:
	brlo.d r13,0x2,L_8d5214
L_8d5144:
	add2 r24,sp,0x21
L_8d5148:
	cmp_s r0,0x2
L_8d514a:
	cmp.ne r0,0x1
L_8d514e:
	cmp.eq r15,0x4
L_8d5152:
	bne_s L_8d5214
L_8d5154:
	ld r0,[r22, 0x4]
L_8d5158:
	cmp_s r13,0x4
L_8d515a:
	st_s r0,[sp,0x60]
L_8d515c:
	ld r0,[sp, 0x8c]
L_8d5160:
	st r0,[sp, 0x84]
L_8d5164:
	mov.eq r0,0x3
L_8d5168:
	mov.eq r14,0x2
L_8d516c:
	beq_s L_8d517e
L_8d516e:
	cmp_s r13,0x3
L_8d5170:
	mov_s r14,0x2
L_8d5172:
	mov.eq r0,0x4
L_8d5176:
	mov.ne r0,0x4
L_8d517a:
	mov.ne r14,0x3
	.global L_8d517e
L_8d517e:
	add r1,sp,r0
L_8d5182:
	add r2,sp,r14
L_8d5186:
	ldb r1,[r1, 0x5f]
L_8d518a:
	ldb r2,[r2, 0x5f]
L_8d518e:
	brge r1,r2,L_8d5198
L_8d5192:
	stb r14,[sp, 0x94]
L_8d5196:
	b_s L_8d519e
	.global L_8d5198
L_8d5198:
	stb r0,[sp, 0x94]
L_8d519c:
	mov_s r14,r0
	.global L_8d519e
L_8d519e:
	add r0,sp,r14
L_8d51a2:
	ldb r1,[r0, 0x5f]
L_8d51a6:
	brlt r1,0x1,L_8d5214
L_8d51aa:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8d51ac:
	stb r1,[r0, 0x5f]
L_8d51b0:
	stb_s r14,[sp,0x6c]
L_8d51b2:
	mov_s r0,sp
L_8d51b4:
	add3 r1,sp,0x1d
L_8d51b8:
	bl.d L_8c0380
L_8d51bc:
	mov_s r2,0xc
L_8d51be:
	st r21,[sp, 0xc]
L_8d51c2:
	st_s r14,[sp,0x10]
L_8d51c4:
	st r23,[sp, 0x14]
L_8d51c8:
	st r24,[sp, 0x18]
L_8d51cc:
	ld_s r3,[sp,0x40]
L_8d51ce:
	mov_s r0,0x1
L_8d51d0:
	ld r6,[sp, 0x44]
L_8d51d4:
	mov_s r1,r16
L_8d51d6:
	mov_s r2,r17
L_8d51d8:
	mov r4,r19
L_8d51dc:
	mov r5,r20
L_8d51e0:
	bl.d L_8d4e08
L_8d51e4:
	ld r7,[sp, 0x48]
L_8d51e8:
	mov_s r0,sp
L_8d51ea:
	add2 r1,sp,0x39
L_8d51ee:
	bl.d L_8c0380
L_8d51f2:
	mov_s r2,0x10
L_8d51f4:
	ld_s r0,[sp,0x70]
L_8d51f6:
	mov_s r2,r16
L_8d51f8:
	ld_s r1,[sp,0x74]
L_8d51fa:
	mov_s r3,r17
L_8d51fc:
	ld r4,[sp, 0x40]
L_8d5200:
	mov r5,r19
L_8d5204:
	mov r6,r20
L_8d5208:
	bl.d L_8dcb6c
L_8d520c:
	ld r7,[sp, 0x44]
L_8d5210:
	ld r18,[sp, 0x70]
	.global L_8d5214
L_8d5214:
	stb_s r13,[sp,0x6c]
L_8d5216:
	stb r15,[r25, 0x5f]
L_8d521a:
	mov_s r0,sp
L_8d521c:
	add3 r1,sp,0x1d
L_8d5220:
	bl.d L_8c0380
L_8d5224:
	mov_s r2,0xc
L_8d5226:
	st r21,[sp, 0xc]
L_8d522a:
	st_s r13,[sp,0x10]
L_8d522c:
	st r23,[sp, 0x14]
L_8d5230:
	st r24,[sp, 0x18]
L_8d5234:
	ld_s r3,[sp,0x40]
L_8d5236:
	mov_s r0,0x1
L_8d5238:
	ld r6,[sp, 0x44]
L_8d523c:
	mov_s r1,r16
L_8d523e:
	mov_s r2,r17
L_8d5240:
	mov r4,r19
L_8d5244:
	mov r5,r20
L_8d5248:
	bl.d L_8d4e08
L_8d524c:
	ld r7,[sp, 0x48]
L_8d5250:
	mov_s r0,sp
L_8d5252:
	add2 r1,sp,0x39
L_8d5256:
	bl.d L_8c0380
L_8d525a:
	mov_s r2,0x10
L_8d525c:
	ld_s r0,[sp,0x70]
L_8d525e:
	mov_s r2,r16
L_8d5260:
	ld_s r1,[sp,0x74]
L_8d5262:
	mov_s r3,r17
L_8d5264:
	ld r4,[sp, 0x40]
L_8d5268:
	mov r5,r19
L_8d526c:
	mov r6,r20
L_8d5270:
	bl.d L_8dcb6c
L_8d5274:
	ld r7,[sp, 0x44]
L_8d5278:
	ldb_s r0,[sp,0x74]
L_8d527a:
	brne_s r0,0,L_8d5282
L_8d527c:
	ldb r0,[sp, 0x75]
L_8d5280:
	breq_s r0,0,L_8d52ac
	.global L_8d5282
L_8d5282:
	mov_s r0,r16
L_8d5284:
	bl.d L_8e97bc
L_8d5288:
	mov_s r1,0x1
L_8d528a:
	mov_s r5,r0
L_8d528c:
	ldb_s r0,[sp,0x74]
L_8d528e:
	mov_s r1,0x101caa0
L_8d5294:
	ldb r2,[sp, 0x75]
L_8d5298:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8d529a:
	add r4,r0,r2
L_8d529e:
	mov_s r0,0x16
L_8d52a0:
	mov_s r2,r13
L_8d52a2:
	bl.d L_8dcd00
L_8d52a6:
	mov_s r3,r5
L_8d52a8:
	mov_s r0,0x2
L_8d52aa:
	st_s r0,[sp,0x58]
	.global L_8d52ac
L_8d52ac:
	ld r1,[sp, 0xf8]
L_8d52b0:
	asl_s r0,r13,0x5
L_8d52b2:
	add_s r1,r1,r0
L_8d52b4:
	ld_s r0,[sp,0x70]
L_8d52b6:
	sub r1,r1,0x24
L_8d52ba:
	sub r0,r0,r18
L_8d52be:
	add2_s r1,r1,r15
L_8d52c0:
	st_s r0,[r1]
L_8d52c2:
	b_s L_8d511c
	.global L_8d52c4
L_8d52c4:
	mov_s r12,0x24
L_8d52c6:
	b.d L_8c01fe
L_8d52ca:
	add sp,sp,0x98
L_8d52ce:
	nop_s
